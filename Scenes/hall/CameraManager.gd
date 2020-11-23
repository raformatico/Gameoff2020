extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var camera_boxes=get_children()
	
#	for camera in camera_boxes:
#		camera.connect("body_entered",self,"on_area_entered")



func on_area_entered(body):
	if body.is_in_group("Character"):
		var camera=get_node(str(body.get_path())+"/camera")
		camera.make_current()

func set_camera(camera_):
	var camera=get_node("../"+camera_+"/"+camera_+"_Orientation")
	camera.make_current()
