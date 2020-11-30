extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween=get_node("Tween")
	tween.interpolate_property(get_node(".."), "unit_offset",
		0, 1, 10,
		Tween.TRANS_QUAD , Tween.EASE_IN_OUT)
	tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
