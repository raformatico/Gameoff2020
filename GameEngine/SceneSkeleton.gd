extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var gateways=null

# Called when the node enters the scene tree for the first time.
func _ready():
	gateways=get_tree().get_nodes_in_group("Gateway")
	start_entrance()  #A pity... start_entrance doesn't work...

func start_entrance():
	var gateway_name=Global.get_gateway()
	
	for g in gateways:
		if g.gateway_name==gateway_name:
			$Alex.global_transform.origin=get_node(str(g.get_path())+"/outdoor").global_transform.origin
			# $Alex.global_transform.basis=get_node(str(g.get_path())+"/outdoor").global_transform.basis.get_euler()
			
			#$PointAndClickManager.set_alex_path(get_node(str(g.get_path())+"/outdoor").global_transform.origin,get_node(str(g.get_path())+"/outdoor").global_transform.basis.get_euler())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
