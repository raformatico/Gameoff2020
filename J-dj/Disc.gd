extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed=1
export var on=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if on:
		rotate(Vector3(0,1,0),delta*speed)


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if (event is InputEventMouseButton and event.is_pressed() == true):
		on=!on	
		if on:
			$AudioStreamPlayer2D.play()
		else:
			$AudioStreamPlayer2D.stop()
