extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var smoke = get_node("smoke")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.broken_aspiradora:
		visible=true
		smoke.enable_emitting()
