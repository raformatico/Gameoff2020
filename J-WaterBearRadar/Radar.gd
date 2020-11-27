extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_scale=10
export var time=3

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self, "scale",
	Vector3(0, 0,0), Vector3(max_scale,max_scale,max_scale), time, 
	Tween.TRANS_EXPO, Tween.EASE_IN)
	
	$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	


func _on_Radar_body_entered(body):
	print(body.name)
	body.highlight()
