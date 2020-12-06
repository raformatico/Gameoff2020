extends Control

var text_en = """Developers
Juanjo Ramos
Raformatico https://www.youtube.com/c/raformatico

Audio
Ignacio Segura
Man from Space
SoundCloud https://soundcloud.com/manfromspace

Design
Fran Arroyo 
Pablo Ruiz
http://somoschumbo.com/
"""

var text_spa = """Desarrolladores
Juanjo Ramos
Raformatico https://www.youtube.com/c/raformatico

Audio
Ignacio Segura
Man from Space
SoundCloud https://soundcloud.com/manfromspace

Diseño
Fran Arroyo 
Pablo Ruiz
http://somoschumbo.com/
"""

onready var label : Label = $Label

func _ready() -> void:
	if Global.current_language == Global.LANGUAGE.ENGLISH:
		label.text = text_en
	elif Global.current_language == Global.LANGUAGE.SPANISH:
		label.text = text_spa
	



