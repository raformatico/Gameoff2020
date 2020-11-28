extends Control

var start := "res://Scenes/museum-prefinal/Room.tscn"
var controls := "res://Scenes/museum-prefinal/Room.tscn"
var credits := "res://Scenes/museum-prefinal/Room.tscn"


func _on_start_pressed() -> void:
	get_tree().change_scene(start)


func _on_controls_pressed() -> void:
	get_tree().change_scene(controls)
	

func _on_credits_pressed() -> void:
	get_tree().change_scene(credits)


func _on_exit_pressed() -> void:
	get_tree().quit()
