extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var animator=null
# Called when the node enters the scene tree for the first time.
func _ready():
	animator=$AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func open():
	animator.play("open")
	audio_player.play_opening_door()
	
func set_open():
	animator.play("open")
	animator.seek(animator.current_animation_length,true)
