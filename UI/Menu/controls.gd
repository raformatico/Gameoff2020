extends Control

var text_en = """Click to move (doble click to run)

Click on Alex's head to reveal the items you 
can interact with

Use the items in the scences
1) Open inventory 
2) Select one item
3) Use it by clicking on object in the scene
"""

var text_spa = """Clic para caminar (doble clic para correr)

Clic sobre la cabeza de Alex para mostrar 
los objetos con los que se puede interactuar

Utiliza los objetos en las escenas:
1) Abre el inventario 
b) Selecciona el objeto
c) Utilízalo clicando sobre otro objeto en la escena
"""

onready var label : Label = $Label

func _ready() -> void:
	if Global.current_language == Global.LANGUAGE.ENGLISH:
		label.text = text_en
	elif Global.current_language == Global.LANGUAGE.SPANISH:
		label.text = text_spa
	

