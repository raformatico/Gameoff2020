extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var i=0
var curva : Curve3D =null
var n=0

# Called when the node enters the scene tree for the first time.
func _ready():
	curva=Curve3D.new()
	curva.add_point(Vector3(0,0,0))
	curva.add_point(Vector3(0,0,10))
	curva.add_point(Vector3(10,0,10))
	curva.add_point(Vector3(10,0,0))
	n=curva.get_baked_length()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var punto=curva.interpolate_baked(i)
	i+=delta
	$CSGSphere.transform.origin=punto
	
