extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scenary
var camera_setup={}

# Called when the node enters the scene tree for the first time.
func _ready():
	scenary=get_node("../museo-simple")
	scenary=get_node("../MiniTest")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_area_1_body_entered(body):
	set_camera("camera-1")

func _on_area_2a_body_entered(body):
	set_camera("camera-2a")

func _on_area_2c_body_entered(body):
	set_camera("camera-2c")

func set_camera(camera_):
	var camera=scenary.get_node(camera_+"/camera")
	camera.make_current()
	
