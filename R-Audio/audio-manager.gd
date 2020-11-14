extends Node


var song_i: = 0 

onready var songs: = $songs.get_children()

func _ready() -> void:
	start_all()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("next_song"):
		next_song()

func start_all() -> void:
	for i in range(songs.size()):
		songs[i].play()


func next_song() -> void:
	songs[song_i].volume_db = -80
	song_i = (song_i + 1) % songs.size()
	songs[song_i].volume_db = 0
