extends Node

signal goto(path)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var ray_length=1000



var alex
var navigator

# Called when the node enters the scene tree for the first time.
func _ready():
	alex=get_node("../Alex") # Should Global tell us who the character is?
	connect("goto",alex,"_on_goto")
	navigator=get_node("../museo-simple/Navigation")
	navigator=get_node("../micro-museum/Navigation")
	navigator=get_node("../MiniTest/Navigation")
			
func _unhandled_input(event):
	
	var camera=get_viewport().get_camera()
	
	if event is InputEventMouseButton and event.is_pressed():
		var from=camera.project_ray_origin(event.position)
		var to=from+camera.project_ray_normal(event.position)*ray_length
		var space_state=camera.get_world().direct_space_state
		var result=space_state.intersect_ray(from,to,[],1)
			
		if Global.debug:		
			$destination.global_transform.origin=result.position
			$origine.global_transform.origin=alex.global_transform.origin
			
		if result:
			var path=navigator.get_simple_path(alex.base.global_transform.origin,result.position)
			print(str(alex.base.global_transform.origin)+" -> "+str(result.position))
			if Global.debug:
				$ImmediateGeometry.draw(path)
#			var path_ind = 0
#
#			var curve = Curve3D.new()	
#			curve.bake_interval = 0.1
#			# Set path poits to curve
#			for i in range(len(path)):
#				curve.add_point(path[i])
#			# Draw Line
#			# Create a proper curve from the path (¿Create Smoothed Version?)
#			path = curve.get_baked_points()
			
			emit_signal("goto",path)
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


