extends Control


var counter = 0
var code = ""
onready var label : Label = $Label
onready var timer : Timer = $Timer
onready var correct : AudioStreamPlayer = $correct
onready var wrong : AudioStreamPlayer = $wrong



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = ""


func add_number(number : int) -> void:
	code += str(number)
	label.text += str(number) + " "
	counter += 1
	if counter == 4:
		check_code()


func check_code() -> void:
	if code == "1969":
		print("Correcto")
		timer.start()
		correct.play()
		Global.status["Door"] = "opened"
		yield(timer, "timeout")
		get_tree().change_scene("res://Scenes/museum-final/Room.tscn")
	else:
		print("Incorrecto")
		timer.start()
		wrong.play()
		yield(timer, "timeout")
		code = ""
		counter = 0
		label.text = ""

func _on_1_pressed() -> void:
	add_number(1)


func _on_2_pressed() -> void:
	add_number(2)


func _on_3_pressed() -> void:
	add_number(3)


func _on_4_pressed() -> void:
	add_number(4)


func _on_5_pressed() -> void:
	add_number(5)


func _on_6_pressed() -> void:
	add_number(6)


func _on_7_pressed() -> void:
	add_number(7)


func _on_8_pressed() -> void:
	add_number(8)


func _on_9_pressed() -> void:
	add_number(9)


func _on_0_pressed() -> void:
	add_number(0)


func _on_TextureButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/museum-final/Room.tscn")
