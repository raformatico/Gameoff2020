extends StaticBody


# Declare member variables here. Examples:
# var a = 2
signal start()
signal stop()
# var b = "text"

export var main_rythm=false
export var speed=1
export var on=false
var clock_manager=null

var audio_length=0

var led=null

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_length=$AudioStreamPlayer2D.stream.get_length()
	led=get_node("../Led")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if on:
		var time=$AudioStreamPlayer2D.get_playback_position()*1.0/audio_length
		
		rotate(Vector3(0,1,0),delta*speed)
		# $Label.text=str($AudioStreamPlayer2D.get_playback_position ( ))
		# $CSGBox2.material.albedo_color=Color(time,1,0)

func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if (event is InputEventMouseButton and event.is_pressed() == true):
		var time=0
		on=!on	
		if on:
			emit_signal("start",self)
			if clock_manager!=null:
				time=clock_manager.get_next_instant()
			$AudioStreamPlayer2D.play(time)
			#led.set_color(Color.red)
		else:
			emit_signal("stop",self)
			$AudioStreamPlayer2D.stop()
			led.set_color(Color.gray)

func set_clock_manager(manager_):
	clock_manager=manager_

func get_playback_position():
	return $AudioStreamPlayer2D.get_playback_position()

func get_total_length():
	return $AudioStreamPlayer2D.stream.get_length()

func set_sync(syncr):
	if syncr>0.75:
		led.set_color(Color.red)	
	elif syncr>0.5:
		led.set_color(Color.orange)	
	elif syncr>0.25:
		led.set_color(Color.yellow)
	else:
		led.set_color(Color.green)		
	
