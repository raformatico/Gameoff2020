extends Control

var start := "res://Scenes/Intro/intro.tscn"
#var start := "res://Scenes/museum-final/Room.tscn"
var credits := "res://UI/Menu/controls.tscn"
var controls := "res://UI/Menu/credits.tscn"


func _on_start_pressed() -> void:
	audio_player.play_music()
	get_tree().change_scene(start)


func _on_controls_pressed() -> void:
	get_tree().change_scene(controls)
	

func _on_credits_pressed() -> void:
	get_tree().change_scene(credits)


func _on_exit_pressed() -> void:
	get_tree().quit()
