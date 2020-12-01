extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var channel =[]
var discs=[]

var start_time=0
export var slot_time=250

export var segment_duration=2

var n_discs_playing=0

var main_plato=null

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player.pause_music()
	channel.append($StaticBody/AudioStreamPlayer2D)
	channel.append($StaticBody2/AudioStreamPlayer2D)
	channel.append($StaticBody3/AudioStreamPlayer2D)


	var discs_ = get_tree().get_nodes_in_group("Disc")
#	discs.append($StaticBody)
#	discs.append($StaticBody2)
#	discs.append($StaticBody3)
	

	for disc in discs_:
		if main_plato==null or disc.main_rythm:
			main_plato=disc
			
		discs.append(disc)
		disc.set_clock_manager(self)
		disc.connect("start",self, "_on_disc_start")
		disc.connect("stop",self, "_on_disc_stop")

#	channel[0].play()
#	channel[1].play(2)
#	channel[2].play(4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var play_time=""
	
	for disc in discs:
		play_time+=str(disc.get_playback_position())+"\n"
	$Label.text=play_time

func get_next_instant():
	var time=OS.get_system_time_msecs()-start_time
	return (time%slot_time)/1000.0
	
func _on_disc_start(plato):
	if n_discs_playing==0: # first disc sets the tempo
		start_time=OS.get_system_time_msecs()
		
	n_discs_playing+=1
	
	check_sync()
	
func _on_disc_stop(plato):
	n_discs_playing-=1

func check_sync():
	
	for disc in discs:
		if disc.on:	
			if !disc.main_rythm:
				var diff=abs(disc.get_playback_position()-main_plato.get_playback_position())/disc.get_total_length()
				disc.set_sync(diff)
				print(diff)
			else:			
				disc.set_sync(0)
				print("Main")


func _on_TextureButton_pressed() -> void:
	audio_player.continue_music()
	get_tree().change_scene("res://Scenes/cafeteria/room.tscn")
