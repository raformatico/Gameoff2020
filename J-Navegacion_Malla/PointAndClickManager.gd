extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var ray_length=1000
var alex
var navigator
const Marker = preload("res://J-Navegacion_malla/Marker.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	alex=get_node("../Alex")
	navigator=get_node("../Navigation")

func _unhandled_input(event):
	
	var camera=get_viewport().get_camera()
	
	if event is InputEventMouseButton and event.is_pressed():
		var from=camera.project_ray_origin(event.position)
		var to=from+camera.project_ray_normal(event.position)*ray_length
		var space_state=camera.get_world().direct_space_state
		var result=space_state.intersect_ray(from,to,[],1)
			
		if !result.empty():	
			if Global.debug:
				$destination.global_transform.origin=result.position
				$origine.global_transform.origin=alex.global_transform.origin
#
			var path=navigator.get_simple_path(alex.foot.global_transform.origin,result.position,true)
			path.remove(0)
			alex.set_path(path)
			
			if Global.debug:
				for node in path:
					mark(node)
					
func mark(posi):
	var marker = Marker.instance()
	add_child(marker)
	marker.global_transform.origin = posi
