extends Control

export var is_scene : bool = false
export var previous_scene : String = ""

func _on_back_button_pressed() -> void:
	if is_scene:
		get_tree().change_scene(previous_scene)
	else:
		get_parent().queue_free()
