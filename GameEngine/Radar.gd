extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_scale=10
export var time=3
export var min_scale=0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func lauch():
	$Tween.interpolate_property(self, "scale",
	Vector3(0, 0,0), Vector3(max_scale,max_scale,max_scale), time, 
	Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$CSGSphere.visible=true
	$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Radar_body_entered(body):
	if body.is_in_group("clickable"):
		print(body.name)
		body.highlight()


func _on_Tween_tween_completed(object, key):
	$CSGSphere.visible=false
	global_scale(Vector3.ZERO)	
