class_name Inventory
extends Resource

signal item_deleted(item, index)
signal item_added(item)
signal item_clicked(item_name)

export (Array, Resource) var inventory

var ItemDatabase = {
	"armor" : load("res://Inventory/items/armor.tres"),
	"potion" : load("res://Inventory/items/potion.tres")
}


func list_items() -> void:
	for i in inventory:
		print(i.name)


func add_item(item_name) -> void:
	if not item_name in ItemDatabase:
		print("Item not in Database")
		return
	var item : ItemResource = ItemDatabase[item_name]
	if not item in inventory:
		inventory.append(item)
		emit_signal("item_added", item)
		print(inventory.size())
	elif item.type == ItemResource.ItemType.STACKABLE:
		if item.quantity >= item.max_stack:
			print("Max stack exceeded!")
		else:
			item.quantity += 1
			emit_signal("item_added", item)


func del_item(item_name) -> void:
	var index : int
	if not item_name in ItemDatabase:
		print("Item not in Database")
		return
	var item : ItemResource = ItemDatabase[item_name]
	if not item in inventory:
		inventory.append(item)
		emit_signal("item_deleted", item, index)
