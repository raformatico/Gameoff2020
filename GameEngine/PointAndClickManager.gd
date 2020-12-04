extends Node

export var ray_length=1000
var alex
var navigator
#const Marker = preload("res://J-Navegacion_malla/Marker.tscn")


func _ready():
	alex=get_node("../Alex")
	navigator=get_node("../room/NavigationManager/Navigation")

func _unhandled_input(event):
	
	var camera=get_viewport().get_camera()
	
	if event is InputEventMouseButton and event.is_pressed() and  event.button_index == BUTTON_LEFT:
		var from=camera.project_ray_origin(event.position)
		var to=from+camera.project_ray_normal(event.position)*ray_length
		var space_state=camera.get_world().direct_space_state
		var result=space_state.intersect_ray(from,to,[],1)
			
		if !result.empty():	
			
			if result.collider.is_in_group("Character"): # Is it the main character?
				alex.scan()
			else:
				var destination=result.position
				var rotation_=null
				var target_object=null
				
				alex.clean_path()
			
				if result.collider.is_in_group("clickable"):
					var stand_location=get_node(str(result.collider.get_path())+"/stand-position")
					destination=stand_location.global_transform.origin
					rotation_=stand_location.global_transform.basis.get_euler()
					target_object=result.collider
			
			
				if Global.debug:
					$destination.global_transform.origin=destination
					$origine.global_transform.origin=alex.global_transform.origin
#
				var path=navigator.get_simple_path(alex.foot.global_transform.origin,destination,true)
				path.remove(0)
				
				##################
				path=smooth_path(path)
				#################
				
				alex.set_path(path,rotation_,target_object)
			
				if Global.debug:
					for node in path:
						mark(node)
					
func mark(posi):
	#var marker = Marker.instance()
	#add_child(marker)
	#marker.global_transform.origin = posi
	pass

func smooth_path(path_):
	var curva=Curve3D.new()
	curva.bake_interval=0.1
	
	for pos in path_:
		curva.add_point(pos)
	# n=curva.get_baked_length()
	var pathh=curva.get_baked_points()
	return pathh

func set_alex_path(destination,rotation_):
	var path=navigator.get_simple_path(alex.foot.global_transform.origin,destination,true)
	path.remove(0)
				
				##################
	path=smooth_path(path)
				#################
				
	alex.set_path(path,rotation_,null)
