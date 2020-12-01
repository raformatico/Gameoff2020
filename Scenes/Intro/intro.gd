extends Node

var room := "res://Scenes/museum-final/Room.tscn"

func _on_VideoPlayer_finished() -> void:
	get_tree().change_scene(room)
