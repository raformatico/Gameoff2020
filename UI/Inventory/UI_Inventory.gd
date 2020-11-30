extends Control

var inventory_res : Inventory = preload("res://Inventory/inventory.tres")
var inventory
var inventory_slot_scn := load("res://UI/item_slot.tscn")
var slot_selected : InventorySlot
var i : int = 0

onready var background : TextureRect = $background
onready var out_inventory : ColorRect = $out_inventory
onready var inventory_grid : GridContainer = $inventory_display
onready var inventory_but : TextureButton = $inventory_but
onready var dialog = get_node("../Dialog")

func _ready() -> void:
	inventory_res.connect("item_clicked", self, "_on_item_clicked")
	inventory_res.connect("deselect_all", self, "_on_deselect_all")
	inventory_res.connect("item_added", self, "_on_item_added")
	inventory_res.connect("item_deleted", self, "_on_item_deleted")
	inventory = inventory_res.inventory
	"""inventory_grid.columns = inventory.size()
	var slot : InventorySlot
	for i in range(inventory.size()):
		slot = inventory_slot_scn.instance()
		inventory_grid.add_child(slot)
		slot.display_item(inventory[i])"""


func _on_item_added_old(item : ItemResource) -> void:
	if item.quantity == 1:
		inventory_grid.columns += 1
		var slot : InventorySlot = inventory_slot_scn.instance()
		inventory_grid.add_child(slot)
		slot.display_item(item)
	else:
		for slot in inventory_grid.get_children():
			if slot.slot_name == item.name:
				slot.display_item(item)

func _on_item_added(item : ItemResource) -> void:
	if item.quantity == 1:
		var new_item_position = inventory.size() - 1
		i = 0
		for slot in inventory_grid.get_children():
			if i == new_item_position:
				slot.display_item(item)
			i += 1
	else:
		for slot in inventory_grid.get_children():
			if slot.slot_name == item.name:
				slot.display_item(item)



func _on_item_deleted_old(item : ItemResource, index : int) -> void:
	var i = 0
	for slot in inventory_grid.get_children():
		if i == index:
			slot.queue_free()
		i += 1
	inventory_grid.columns -= 1


func _on_item_deleted(item : ItemResource, index : int) -> void:
	var i = 0
	for slot in inventory_grid.get_children():
		if i == index:
			slot.hide_item()
		i += 1


func _on_item_clicked (slot : InventorySlot) -> void:
	if slot == slot_selected:
		deselect_slot(slot)
	else:
		if slot_selected:
			slot_selected.deselect_item()
		slot.select_item()
		Global.set_item_selected(slot.slot_name)
		slot_selected = slot

func _on_deselect_all() -> void:
	for s in inventory_grid.get_children():
		if s == slot_selected:
			deselect_slot(s)


func deselect_slot(slot) -> void:
	slot.deselect_item()
	slot_selected = null
	Global.set_item_selected(null)


func show_inventory() -> void:
	background.show()
	inventory_grid.show()
	out_inventory.show()
	

func hide_inventory() -> void:
	background.hide()
	inventory_grid.hide()
	out_inventory.hide()

func _on_inventory_but_pressed() -> void:
	if background.visible:
		hide_inventory()
	else:
		show_inventory()


func _on_out_inventory_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		hide_inventory()


#TODO Connect this!!!
func _on_Dialog_visibility_changed() -> void:
	if dialog.visible:
		visible = false
	else:
		visible = true


func _on_Dialog_show_dialog() -> void:
	hide()


func _on_Dialog_hide_dialog() -> void:
	show()
