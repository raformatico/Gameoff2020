extends KinematicBody

export var speed = 5
export var gravity = -5

var target = null
var velocity = Vector3.ZERO

func _physics_process(delta):
	velocity.y += gravity * delta
	if target:
		look_at(target, Vector3.UP)
		rotation.x = 0
		velocity = -transform.basis.z * speed
		if transform.origin.distance_to(target) < .5:
			target = null
			velocity = Vector3.ZERO
	velocity = move_and_slide(velocity, Vector3.UP)
