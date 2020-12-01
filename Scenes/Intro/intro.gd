extends Node

var room := "res://Scenes/museum-final/Room.tscn"

func _on_VideoPlayer_finished() -> void:
	get_tree().change_scene(room)

func _process(delta):
	if Input.is_action_pressed("stop"):
		get_tree().change_scene(room)
