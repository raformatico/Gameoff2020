extends Control

var inventory_res : Inventory = preload("res://Inventory/inventory.tres")
var inventory
var inventory_slot_scn := load("res://UI/item_slot.tscn")
var slot_selected : InventorySlot

onready var background : TextureRect = $background
onready var out_inventory : TextureRect = $out_inventory
onready var inventory_grid : GridContainer = $inventory_display
onready var inventory_but : TextureButton = $inventory_but
onready var dialog = get_node("../Dialog")

func _ready() -> void:
	inventory_res.connect("item_clicked", self, "_on_item_clicked")
	inventory_res.connect("item_added", self, "_on_item_added")
	inventory_res.connect("item_deleted", self, "_on_item_deleted")
	inventory = inventory_res.inventory
	inventory_grid.columns = inventory.size()
	var slot : InventorySlot
	for i in range(inventory.size()):
		slot = inventory_slot_scn.instance()
		inventory_grid.add_child(slot)
		slot.display_item(inventory[i])

func _on_item_added(item : ItemResource) -> void:
	inventory_grid.columns += 1
	var slot : InventorySlot = inventory_slot_scn.instance()
	inventory_grid.add_child(slot)
	
	slot.display_item(item)


func _on_item_deleted(item : ItemResource, index : int) -> void:
	var i = 0
	for slot in inventory_grid.get_children():
		if i == index:
			slot.queue_free()
		i += 1
	inventory_grid.columns -= 1


func _on_item_clicked (slot : InventorySlot) -> void:
	if slot == slot_selected:
		slot.deselect_item()
		slot_selected = null
	else:
		if slot_selected:
			slot_selected.deselect_item()
		slot.select_item()
		slot_selected = slot

func show_inventory() -> void:
	inventory_but.hide()
	background.show()
	inventory_grid.show()
	out_inventory.show()
	

func hide_inventory() -> void:
	background.hide()
	inventory_grid.hide()
	out_inventory.hide()
	inventory_but.show()

func _on_inventory_but_pressed() -> void:
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
