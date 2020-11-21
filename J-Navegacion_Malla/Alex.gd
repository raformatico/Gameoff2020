extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var path=null
var target_point=null
export var threshold=1
export var speed=10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction=-Vector3.UP*speed
	
	
		
	if target_point!=null:
			
		if Global.debug:		
			print($Foot.global_transform.origin.distance_to(target_point))
		if $Foot.global_transform.origin.distance_to(target_point)<threshold:
			if path!=null and !path.empty():
				target_point=path[0]
				path.remove(0)
					
			else:
				path=null
				target_point=null
				print("Arrrived!")
				
				$AnimationPlayer.play("idle")
		
		
		var grav=Vector3.ZERO
		if !is_on_floor():
			grav.y=-10
		
		if target_point!=null:
			$AnimationPlayer.play("Walk")
			look_at(target_point,Vector3.UP)
			rotation.x=0
			move_and_slide(-transform.basis.z*speed+grav,Vector3.UP,false)		
			rotate(Vector3.UP,PI)
			
func set_path(path_):
	path=path_
	target_point=path[0]
	look_at(target_point,Vector3.UP)
