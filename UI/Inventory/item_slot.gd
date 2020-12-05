class_name InventorySlot
extends CenterContainer

var slot_name = null
onready var itemTexture := $TextureRect
var inventory_res : Inventory = preload("res://Inventory/inventory.tres")

func display_item(item : ItemResource) -> void:
	slot_name = item.name
	if item.type == ItemResource.ItemType.STACKABLE:
		itemTexture.texture = item.texture_array[item.quantity-1]
	else:
		itemTexture.texture = item.texture
	

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
