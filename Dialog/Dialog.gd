extends Control

var tardis_portrait = "res://R-Dialogos/Tardi-dia.png"
var alex_portrait = "res://R-Dialogos/Player-dia.png"

enum SIDE {LEFT, RIGHT}
var character_talking : int = SIDE.LEFT
var current_character := "Alex"
var current_dialog : Array
var text_count := 0


var dialog_dictionary = {
	"door_scene1" : {
		"without_keys" : [["Alex","No tengo las llaves"],["Tardis","Pues a por ellas campeón"],["Alex", "Ok"]],
		"with_keys" : [["Tardis", "Si no hubiera sido por mi no las habrías encontrado"],["Alex", "Gracias amiguito"]],
	},
	"coffemachine_scene2" : {
		"first_time" : [["CHARACTER","TEXT TO SAY"],[],[]],
	},
	"tree_scene3" : {
		"with_water" : [[""],[],[]],
	}
}


onready var left_portrait: = $text_box/left_portrait
onready var right_portrait: = $text_box/right_portrait
onready var rich_text := $text_box/text

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("next_song"):
		start_dialog("door_scene1")
	if Input.is_action_just_pressed("next_dialog"):
		if visible == true:
			next_dialog()


func start_dialog(node_label : String) -> void:
	var status = get_status(node_label)
	current_dialog = dialog_dictionary[node_label][status]
	show_dialog()
	next_dialog()


func get_status(node_label : String) -> String:
	return "without_keys"
	
	
func next_dialog() -> void:
	if text_count == current_dialog.size():
		hide_dialog()
	else:
		var previous_character = current_character
		var current_text_to_show : Array = current_dialog[text_count]
		current_character = current_text_to_show[0]
		if current_character != previous_character:
			change_character()
		change_text(current_text_to_show[1])
		text_count += 1
	
	
func change_character() -> void:
	if character_talking == SIDE.LEFT:
		left_portrait.visible = false
		right_portrait.visible = true
		character_talking = SIDE.RIGHT
	else:
		left_portrait.visible = true
		right_portrait.visible = false
		character_talking = SIDE.LEFT


func change_text(new_text : String) -> void:
	rich_text.text = new_text


func hide_dialog() -> void:
	visible = false
	text_count = 0


func show_dialog() -> void:
	right_portrait.visible = false
	var label = current_dialog[0][0]
	if label == "Alex":
		left_portrait.texture = load(alex_portrait)
	elif label == "Tardis":
		left_portrait.texture = load(tardis_portrait)
	left_portrait.visible = true
	visible = true
		
		
		
		
		
		
		
		
	
