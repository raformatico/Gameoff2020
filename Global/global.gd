extends Node

signal start_dialog(object_name, status)
var debug: = false

var status_database = {
	"Statue" : ["without_armor","with_armor","win_battle"],
	"Cube027" : ["without_statue","with_statue", "with_armor"]
}

var status = {
	"door_scene1" : "without_keys",
	"Statue" : "without_armor",
	"Cube027" : "without_statue"
}

func _on_Alex_arrived(object) -> void:
	if object.name in status:
		emit_signal("start_dialog",object.name, status[object.name])
