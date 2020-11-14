extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var position_threshold=0.005
export var speed=2
export var gravity=1

enum State {idle,walking,walkingup}
var state=State.idle
var animator
var velocity=Vector3(0,0,0)
var move_vec=Vector3.ZERO

var path=null
var target_position=null

# Called when the node enters the scene tree for the first time.
func _ready():
	animator=$AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	match(state):
		State.idle:
			animator.play("idle")
		State.walking:
			
			animator.play("walking")
			
			#velocity=-transform.basis.z * speed *delta
			velocity=move_vec.normalized() * speed
			velocity=move_and_slide(velocity,Vector3.UP, false, 5, 0.8, true)+Vector3.DOWN*gravity
			
			# print(str(global_transform.origin)+" -> " +str(target_position))
			
			if global_transform.origin.distance_to(target_position) < position_threshold:
				if path.size()>0:
					target_position=path[0]
					target_position.y=translation.y
					move_vec = (target_position - global_transform.origin)
					
					look_at(target_position,Vector3.UP)		
					path.remove(0)

					print("cambio: "+str(transform.origin)+" -> "+str(global_transform.origin)+" -> " +str(target_position))

				else:
					print("Arrived!")
					animator.play("idle")
					state=State.idle
					print(str(transform.origin)+" -> "+str(global_transform.origin)+" -> " +str(target_position))
					
func _on_goto(path_):
	path=path_
	state=State.walking	
	
	target_position=path[0]
	target_position.y=translation.y
	move_vec = (target_position - global_transform.origin)
	
	look_at(target_position,Vector3.UP)		
	
	path.remove(0)
	
	print(path_)
