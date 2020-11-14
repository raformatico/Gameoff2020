extends ImmediateGeometry


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func draw(path):
	begin(Mesh.PRIMITIVE_LINES)
	
	for v in range(1,path.size()):
		set_color(Color.crimson)
		add_vertex(path[v-1]+Vector3(0,1,0))
		add_vertex(path[v]+Vector3(0,1,0))
	end()
