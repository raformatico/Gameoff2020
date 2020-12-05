extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var gateways=null

# Called when the node enters the scene tree for the first time.
func _ready():
	gateways=get_tree().get_nodes_in_group("Gateway")
	
	# is it an entrance?
	if Global.saved_position==null:
		start_entrance()  #A pity... start_entrance doesn't work...
	else:
		restore_position(Global.saved_position, Global.saved_rotation)

func get_position():
	return $Alex.global_transform.origin

func get_rotation():
	return $Alex.global_transform.basis
	
func restore_position(saved_position, saved_rotation):
	$Alex.global_transform.origin=Global.saved_position
	$Alex.global_transform.basis=Global.saved_rotation
	$Alex.set_rest_position()
		
func start_entrance():
	var gateway_name=Global.get_gateway()
	# Global.changing_scenario=false
	
	for g in gateways:
		if g.gateway_name==gateway_name:
			$Alex.global_transform.origin=get_node(str(g.get_path())+"/indoor").global_transform.origin
			# $Alex.global_transform.basis=get_node(str(g.get_path())+"/outdoor").global_transform.basis.get_euler()
			$PointAndClickManager.set_alex_path(get_node(str(g.get_path())+"/outdoor").global_transform.origin,get_node(str(g.get_path())+"/outdoor").global_transform.basis.get_euler())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
