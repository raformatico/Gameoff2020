extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dialog

# Called when the node enters the scene tree for the first time.
func _ready():
#	var clickables=get_nodes_in_group("clickables")
#
#	for clickable in clickables:
		# dialog=get_node("../MiniDialog/")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Alex_arrived(object):
	print("SceneLogic: Oh! This is a "+str(object.name))
