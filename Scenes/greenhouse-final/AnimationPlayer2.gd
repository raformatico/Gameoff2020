extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("coffee_served",self,"on_coffee_served")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func on_coffee_served():
	play("caer")
	get_node("../AnimationPlayer").play("Crecer")


