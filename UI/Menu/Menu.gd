extends Control

var start := "res://Scenes/Intro/intro.tscn"
#var start := "res://Scenes/museum-final/Room.tscn"
var credits := "res://UI/Menu/credits.tscn"
var controls := "res://UI/Menu/controls.tscn"

onready var spanish := $VBoxContainer/spanish
onready var english := $VBoxContainer/english

func _ready() -> void:
	if Global.current_language == Global.LANGUAGE.ENGLISH:
		if not english.pressed:
			_on_english_toggled(true)
	elif Global.current_language == Global.LANGUAGE.SPANISH:
		if not spanish.pressed:
			_on_spanish_toggled(true)


func _on_start_pressed() -> void:
	audio_player.play_music()
	get_tree().change_scene(start)


func _on_controls_pressed() -> void:
	get_tree().change_scene(controls)
	

func _on_credits_pressed() -> void:
	get_tree().change_scene(credits)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_english_toggled(button_pressed: bool) -> void:
	if button_pressed:
		Global.emit_signal("change_language",Global.LANGUAGE.ENGLISH)
		spanish.pressed = false
	else:
		Global.emit_signal("change_language",Global.LANGUAGE.SPANISH)
		spanish.pressed = true


func _on_spanish_toggled(button_pressed: bool) -> void:
	if button_pressed:
		Global.emit_signal("change_language",Global.LANGUAGE.SPANISH)
		english.pressed = false
	else:
		Global.emit_signal("change_language",Global.LANGUAGE.ENGLISH)
		english.pressed = true













func _on_button_pressed() -> void:
	pass # Replace with function body.
