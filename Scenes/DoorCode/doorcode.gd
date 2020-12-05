extends Control


var counter = 0
var code = ""
onready var label : Label = $Label
onready var timer : Timer = $Timer
onready var correct : AudioStreamPlayer = $correct
onready var wrong : AudioStreamPlayer = $wrong
onready var tap : AudioStreamPlayer = $tap


func _ready() -> void:
	label.text = ""


func add_number(number : int) -> void:
	tap.play()
	code += str(number)
	label.text += str(number) + " "
	counter += 1
	if counter == 4:
		check_code()


func check_code() -> void:
	if code == "1969":
		timer.start()
		correct.play()
		Global.gateways["hall2greenhouse"].status = "opening"
		yield(timer, "timeout")
		get_tree().change_scene("res://Scenes/museum-final/Room.tscn")
	else:
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
