extends Control

onready var chip : TextureRect = $chip2
onready var gear : TextureRect = $gear2
onready var wire : TextureRect = $wire2
onready var crackle : AudioStreamPlayer = $crackle
onready var bigdoor : AudioStreamPlayer = $bigdoor

func _ready() -> void:
	print(Global.status["chip"])
	if Global.status["chip"] == "connected":
		chip.visible = true
	if Global.status["gear"] == "connected":
		gear.visible = true
	if Global.status["wire"] == "connected":
		wire.visible = true

func is_end() -> bool:
	if chip.visible and gear.visible and wire.visible:
		Global.status["InterruptorBox"] = "opendoor"
		Global.emit_signal("start_dialog","InterruptorBox", Global.status["InterruptorBox"])
		bigdoor.play()
		return true
	return false

func _on_back_pressed() -> void:
	# get_tree().change_scene("res://Scenes/museum-prefinal/Room.tscn")
	# Global.gateway_entered("Main")
	Global.restore_point("res://Scenes/museum-final/Room.tscn")

func _on_gear_pressed() -> void:
	if Global.item_selected == "gear":
		gear.visible = true
		if not is_end():
			Global.emit_signal("start_dialog_item","gear", "gear", Global.item_selected, Global.interactions[Global.item_selected])
	elif Global.item_selected != null:
		Global.emit_signal("start_dialog","Error", "start")
	else:
		Global.emit_signal("start_dialog","gear", Global.status["gear"])

func _on_wire_pressed() -> void:
	if Global.item_selected == "wire":
		wire.visible = true
		if not is_end():
			Global.emit_signal("start_dialog_item","wire", "wire", Global.item_selected, Global.interactions[Global.item_selected])
	elif Global.item_selected != null:
		Global.emit_signal("start_dialog","Error", "start")
	else:
		Global.emit_signal("start_dialog","wire", Global.status["wire"])


func _on_chip_pressed() -> void:
	if Global.item_selected == "chip":
		chip.visible = true
		crackle.play()
		if not is_end():
			Global.emit_signal("start_dialog_item","chip", "chip", Global.item_selected, Global.interactions[Global.item_selected])
	elif Global.item_selected != null:
		Global.emit_signal("start_dialog","Error", "start")
	else:
		Global.emit_signal("start_dialog","chip", Global.status["chip"])
