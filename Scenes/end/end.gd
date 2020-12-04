extends Control


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	get_tree().change_scene("res://UI/Menu/Menu.tscn")
