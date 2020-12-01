class_name InventorySlot
extends CenterContainer

var slot_name = null
onready var itemTexture := $TextureRect
var inventory_res : Inventory = preload("res://Inventory/inventory.tres")

func display_item(item : ItemResource) -> void:
	itemTexture.texture = item.texture
	slot_name = item.name
	if item.type == ItemResource.ItemType.STACKABLE:
		$TextureRect/Label.text = str(item.quantity) + "/" + str(item.max_stack)
		$TextureRect/Label.show()


func hide_item() -> void:
	slot_name = null
	itemTexture.texture = null
	$TextureRect/Label.hide()

func select_item() -> void:
	if slot_name != null:
		$selected_texture.visible = true


func deselect_item() -> void:
	$selected_texture.visible = false


func _on_TextureRect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		inventory_res.emit_signal("item_clicked",self)
