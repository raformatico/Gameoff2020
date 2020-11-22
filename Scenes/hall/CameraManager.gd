extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var camera_boxes=get_tree().get_nodes_in_group("camera_manager")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered_camera2(body):
	set_camera("Camera002")


func _on_Area_body_entered_camera4(body):
	set_camera("Camera004")


func _on_Area_body_entered_camera3(body):
	set_camera("Camera003")

func set_camera(camera_):
	var camera=get_node("../"+camera_+"/"+camera_+"_Orientation")
	camera.make_current()
