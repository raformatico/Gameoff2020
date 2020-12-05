extends Control

export var previous_scene : String = ""

func _on_back_button_pressed() -> void:
	get_tree().change_scene(previous_scene)
