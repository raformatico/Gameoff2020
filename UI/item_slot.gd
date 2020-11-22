class_name InventorySlot
extends CenterContainer

var slot_name
onready var itemTexture := $TextureRect
#TODO is that well done? Or may I connect all the slots with the UI with a signal 
var inventory_res : Inventory = preload("res://Inventory/inventory.tres")

func display_item(item : ItemResource) -> void:
	itemTexture.texture = item.texture
	slot_name = item.name


func select_item() -> void:
	print("Item selected :)")
	print(slot_name)


func deselect_item() -> void:
	print("\tDeselected :(")
	print("\t"+slot_name)



func _on_TextureRect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		inventory_res.emit_signal("item_clicked",self)
