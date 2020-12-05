extends Node



func _ready() -> void:
	pass # Replace with function body.


func play_water() -> void:
	$water.play()


func play_music() -> void:
	$music.play()


func pause_music() -> void:
	$music.stream_paused = true


func continue_music() -> void:
	$music.stream_paused = false
	

func play_opening_door() -> void:
	$opening_door.play()


func pause_opening_door() -> void:
	$opening_door.stream_paused = true
