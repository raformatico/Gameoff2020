extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var position_threshold=0.8
export var speed=90
export var gravity=2

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
	var vup
	
	match(state):
		State.idle:
			animator.play("idle")
			
			######
#			var camera=get_viewport().get_camera()
#			var from=camera.project_ray_origin(get_viewport().get_mouse_position())
#			var to=from+camera.project_ray_normal(get_viewport().get_mouse_position())*1000
#			var space_state=camera.get_world().direct_space_state
#			var result=space_state.intersect_ray(from,to,[],1)
#			if result:
#				var vup=global_transform.basis.y
#				look_at(result.position,Vector3.UP)
#				global_transform.basis.y=vup
			#########
			
		State.walking:
			
			animator.play("Walk")
			
#			var vup=global_transform.basis.y
#			look_at(target_position,Vector3.UP)
#			global_transform.basis.y=vup
			
			move_vec = (target_position - global_transform.origin)
			
			# velocity=-transform.basis.z * speed
			velocity=move_vec.normalized() * speed * delta
			var grav=Vector3.DOWN*gravity
			if is_on_floor():
				grav=Vector3.ZERO
			velocity=move_and_slide(velocity+grav,Vector3.UP, false, 5, 0.9, true) # +Vector3.DOWN*gravity
			
			
			# print(str(global_transform.origin)+" -> " +str(target_position))
			
			if global_transform.origin.distance_to(target_position) < position_threshold:
				if path.size()>0:
					target_position=path[0]
					target_position.y=translation.y
					
					move_vec = (target_position - global_transform.origin)
					
					vup=global_transform.basis.y
					look_at(target_position,Vector3.UP)		
					global_transform.basis.y=vup
#
					path.remove(0)

					print("cambio: "+str(transform.origin)+" -> "+str(global_transform.origin)+" -> " +str(target_position))

				else:
					print("Arrived!")
					animator.play("idle")
					state=State.idle
					print(str(transform.origin)+" -> "+str(global_transform.origin)+" -> " +str(target_position))
					
func _on_goto(path_):
	path=path_	
	
	target_position=path[1]
	target_position.y=translation.y
	
	move_vec = (target_position - global_transform.origin)

	look_at_path(target_position)
	state=State.walking	
	
	path.remove(0)
	path.remove(0)
	
	
	if Global.debug:
		print(path_)

func look_at_path(pos):
	var vup=global_transform.origin.y	
	look_at(pos,Vector3.UP)		
	global_transform.origin.y=vup
	
