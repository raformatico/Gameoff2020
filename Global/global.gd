extends Node

signal start_dialog(object_name, status)
signal start_dialog_item(object_name, status, item_selected)

var debug: = false
var item_selected = null setget set_item_selected
var inventory_res : Inventory = preload("res://Inventory/inventory.tres")

var status_database = {
	"Statue" : ["start","read1","read2"],
	"Wax1" : ["start"],
	"Wax2" : ["start"],
	"Wax3" : ["start"],
	"Wax4" : ["start"],
	"Wax5" : ["start"],
	"Cup" : ["start"],
	"McMoon" : ["start"],
	"Vitrina1" : ["start"],
	"Vitrina2" : ["start"],
	"Vitrina3" : ["start"],
	"Cuadro1" : ["start"],
	"Cuadro2" : ["start"],
	"Cuadro3" : ["start"],
	"Window" : ["start"],
	"DownFloor" : ["start"],
	"InterruptorBox" : ["start", "with_wire", "with_gear", "with_chip", "with_everythin"],
}

var status = {
	"Statue" : "start",
	"Wax1" : "start",
	"Wax2" : "start",
	"Wax3" : "start",
	"Wax4" : "start",
	"Wax5" : "start",
	"Cup" : "start",
	"McMoon" : "start",
	"Vitrina1" : "start",
	"Vitrina2" : "start",
	"Vitrina3" : "start",
	"Cuadro1" : "start",
	"Cuadro2" : "start",
	"Cuadro3" : "start",
	"Window" : "start",
	"DownFloor" : "start",
	"InterruptorBox" : "start",
	"Error" : "start"
}

var interactions := {
	"potion" : "Statue",
	"armor" : "Vitrina1"
}

func set_item_selected(item_name) -> void:
	item_selected = item_name
	print(item_name)
	

func _on_Alex_arrived(object) -> void:
	if item_selected != null:
		emit_signal("start_dialog_item",object, status[object.name], item_selected, interactions[item_selected])
	elif object.name in status:
		emit_signal("start_dialog",object, status[object.name])
	

func _on_start_action(object, action : String) -> void:
	if action == "hide":
		object.get_parent().hide()
	if action == "use":
		inventory_res.del_item(object)

var gateways={
	"hall2cafeteria" : "res://Scenes/cafeteria/room.tscn"
}

func gateway_entered(gateway_name):
	var scene=gateways[gateway_name]
	if scene==null:
		scene="res://Scenes/museum-prefinal/Room.tscn"
		get_tree().change_scene (scene)
