extends KinematicBody

signal arrived(object_name)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var path=null
var target_point=null
var target_rotation=null
var target_object=null

export var threshold=1.0
export var speed=10
export var animation_speed=1.0
export var cant_walk_threshold=3.0
var cant_walk=0
var foot

var rotation_tmp_orig=0
var rotation_tmp_dest=0
var rotating=false

# Called when the node enters the scene tree for the first time.
func _ready():
	foot=$Foot
	connect("arrived", Global,"_on_Alex_arrived")
	$AnimationPlayer.playback_speed = animation_speed
	
func clean_path():
	target_object=null
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# var direction=-Vector3.UP*speed
	
	
		
	if target_point!=null:
			
		if Global.debug:		
			#print($Foot.global_transform.origin.distance_to(target_point))
			pass

		if $Foot.global_transform.origin.distance_to(target_point)<threshold:
			if path!=null and !path.empty():
				target_point=path[0]
				path.remove(0)
					
#				##############
#				rotation_tmp_orig=rotation
#				look_at(target_point,Vector3.UP)
#				rotation.x=0
#				rotation_tmp_dest=rotation
#				rotation=rotation_tmp_orig
#
#				var tween = get_node("Tween")
#				tween.interpolate_property(self, "rotation",
#				rotation_tmp_orig, rotation_tmp_dest, 0.3, 
#				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#				tween.start()	
#				rotating=true
#				#################
				
			else: # arived!
				if target_rotation!=null:
					##############
#					rotation_tmp_orig=rotation
#
#					var tween = get_node("Tween")
#					tween.interpolate_property(self, "rotation",
#					rotation_tmp_orig, target_rotation, 1, 
#					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#					tween.start()	
					#################
					rotation=target_rotation
					
				if target_object!=null:
					emit_signal("arrived",target_object)
				
				path=null
				target_point=null
				target_rotation=null
				target_object=null
				
				$AnimationPlayer.play("Stand",0.3)
				start_boring()
		
		var grav=Vector3.ZERO
		if !is_on_floor():
			grav.y=-10
		
		if target_point!=null:
			
			if $AnimationPlayer.current_animation!="Walk":
				$AnimationPlayer.play("Walk",0.5)
			
			if !rotating:	
				look_at(target_point,Vector3.UP)
				rotation.x=0
			
			var movement
			var direction=-transform.basis.z*speed+grav

			movement=move_and_slide(direction,Vector3.UP,false)		
			rotate(Vector3.UP,PI)

#			# am I Stuck?
#			if movement.distance_to(direction)> cant_walk_threshold: # try measuring the real distance last walked, instead
#				# print("mov: "+str(movement.distance_to(direction)))
#				#print("I'm stuck") 
#				pass

func start_boring():
	$Timer.start(5)

func set_path(path_, _rotation=null, _object=null):
	
	if path_!=null and !path_.empty():
		path=path_
		target_point=path[0]
		target_rotation=_rotation
		##look_at(target_point,Vector3.UP)
		
		if _object!=null:
			target_object=_object


func _on_Timer_timeout():
	$AnimationPlayer.play("Idle",0.1)
	$AnimationPlayer.queue("Stand")

func scan():
	$Radar.lauch()
		

func _on_Tween_tween_completed(object, key):
	rotating=false

func set_rest_position():
	$AnimationPlayer.play("Idle")
