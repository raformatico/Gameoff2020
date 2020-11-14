extends Node


var song_i: = 0 

onready var songs: = $songs.get_children()
onready var tween : Tween = $Tween

func _ready() -> void:
	start_all()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("next_song"):
		next_song()

func start_all() -> void:
	for i in range(songs.size()):
		songs[i].play()


func next_song_tween() -> void:
	var first_audio : AudioStreamPlayer = songs[song_i]
	var second_audio : AudioStreamPlayer = songs[(song_i + 1) % songs.size()]
	tween.interpolate_property(first_audio, "volume_db", first_audio.volume_db, -80, 1,Tween.TRANS_SINE,Tween.EASE_IN)
	tween.interpolate_property(second_audio, "volume_db", second_audio.volume_db, 0, 1,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.start()
	song_i = (song_i + 1) % songs.size()


func next_song() -> void:
	songs[song_i].volume_db = -80
	song_i = (song_i + 1) % songs.size()
	songs[song_i].volume_db = 0









