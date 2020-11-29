extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var parent=null
var material=null

# Called when the node enters the scene tree for the first time.
func _ready():
	parent=get_parent()
	material=parent.get_surface_material(0)
	# material=parent.material # for CSG?
	
func highlight():
	if material!=null:
		# material.emission=true
		$Tween.interpolate_property(material, "emission",
		Color.yellow, Color.black, 3, 
		Tween.TRANS_CIRC, Tween.EASE_OUT_IN)
	
		$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func take():	
	if parent!=null:
		parent.visible=false

