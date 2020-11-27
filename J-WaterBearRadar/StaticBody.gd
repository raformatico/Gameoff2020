extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var parent=null
var material=null

# Called when the node enters the scene tree for the first time.
func _ready():
	parent=get_parent()
	# material=parent.get_surface_material(0)
	material=parent.material
	
func highlight():
	$Tween.interpolate_property(material, "emission",
	Color.aqua, Color.black, 3, 
	Tween.TRANS_CIRC, Tween.EASE_OUT_IN)
	
	$Tween.start()

func dehighlight():
	pass
