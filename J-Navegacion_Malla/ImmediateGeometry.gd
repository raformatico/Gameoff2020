extends ImmediateGeometry


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const Marker = preload("res://J-Navegacion_malla/Marker.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func draw(path):
	begin(Mesh.PRIMITIVE_LINES)
	set_color(Color.crimson)	
	for v in range(0,path.size()):
		add_vertex(path[v]+Vector3(0,1,0))
		
		var marker = Marker.instance()
		add_child(marker)
		marker.global_transform.origin = path[v]
		marker.scale_object_local(Vector3(0.5,1,0.5))
		
	end()
