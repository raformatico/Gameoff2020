extends Control

export var button_text_en = ""
export var button_text_spa = ""


onready var label : Label = $button/Label

func _ready() -> void:
	Global.connect("change_language",self, "_on_change_language")
	_on_change_language(Global.current_language)


func _on_change_language(new_language : int):
	if new_language == Global.LANGUAGE.ENGLISH:
		label.text = button_text_en
	elif new_language == Global.LANGUAGE.SPANISH:
		label.text = button_text_spa
