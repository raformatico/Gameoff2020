extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self,"_entering_the_scene")


func _entering_the_scene(body):
	print("Entering...")
	if body.is_in_group("Character"):
		$camera.make_current()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
