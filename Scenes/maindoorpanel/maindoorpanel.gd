extends Control

onready var chip : TextureRect = $chip2
onready var gear : TextureRect = $gear2
onready var wire : TextureRect = $wire2

func _ready() -> void:
	print(Global.status["chip"])
	if Global.status["chip"] == "connected":
		chip.visible = true
	if Global.status["gear"] == "connected":
		gear.visible = true
	if Global.status["wire"] == "connected":
		wire.visible = true

func _on_back_pressed() -> void:
	# get_tree().change_scene("res://Scenes/museum-prefinal/Room.tscn")
	Global.gateway_entered("Main")

func _on_gear_pressed() -> void:
	if Global.item_selected == "gear":
		Global.emit_signal("start_dialog_item","gear", "gear", Global.item_selected, Global.interactions[Global.item_selected])
		gear.visible = true
	elif Global.item_selected != null:
		Global.emit_signal("start_dialog","Error", "start")
	else:
		Global.emit_signal("start_dialog","gear", Global.status["gear"])

func _on_wire_pressed() -> void:
	if Global.item_selected == "wire":
		Global.emit_signal("start_dialog_item","wire", "wire", Global.item_selected, Global.interactions[Global.item_selected])
		wire.visible = true
	elif Global.item_selected != null:
		Global.emit_signal("start_dialog","Error", "start")
	else:
		Global.emit_signal("start_dialog","wire", Global.status["wire"])


func _on_chip_pressed() -> void:
	if Global.item_selected == "chip":
		Global.emit_signal("start_dialog_item","chip", "chip", Global.item_selected, Global.interactions[Global.item_selected])
		chip.visible = true
	elif Global.item_selected != null:
		Global.emit_signal("start_dialog","Error", "start")
	else:
		Global.emit_signal("start_dialog","chip", Global.status["chip"])
