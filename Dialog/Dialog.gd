extends Control

signal show_dialog
signal hide_dialog

const OBJECT = "OBJECT"
const NEXT_STATE = "NEXT_STATE"
enum SIDE {LEFT, RIGHT}

var tardis_portrait = "res://Dialog/assets/Tardi-dia.png"
var alex_portrait = "res://Dialog/assets/Player-dia.png"
var inventory = load("res://Inventory/inventory.tres")
var character_talking : int = SIDE.LEFT
var current_character := "Alex"
var current_dialog : Array
var text_count := 0

var wax = "potion"
var cup = "armor"



var dialog_dictionary = {
	"Statue" : {
		"start" : [["Alex","Este se parece a mi hermano"],["Tardis","Pues es el Gran hermano! Llegó a esta estación en 1984, bonito número, eh?"],["Alex","No te entiendo muy bien..."],[NEXT_STATE,"Statue","read1"]],
		"read1" : [["Alex", "Cuándo decías que llegó el Gran Hermano aquí?"],["Tardis", "En 1984..."],[NEXT_STATE,"Statue","read2"]],
		"read2" : [["Tardis", "Ya hemos hablado de esto... Llegó en 1984"],["Alex", "Que sí, que sí!"],[NEXT_STATE,"Statue","read1"]]
	},
	"Wax1" : {
		#"start" : [["Tardis", "Wax1"],["Alex", "Cogida!"],[OBJECT, wax,"Statue","with_armor","Cube027","with_armor"]]
		"start" : [["Tardis", "Wax1"],["Alex", "Cogida!"],[OBJECT, wax]]
	},
	"Wax2" : {
		"start" : [["Tardis", "Wax2"],["Alex", "Cogida!"]]
	},
	"Wax3" : {
		"start" : [["Tardis", "Wax3"],["Alex", "Cogida!"]]
	},
	"Wax4" : {
		"start" : [["Tardis", "Wax4"],["Alex", "Cogida!"]]
	},
	"Wax5" : {
		"start" : [["Tardis", "Wax5"],["Alex", "Cogida!"]]
	},
	"Cup" : {
		"start" : [["Alex", "Anda una taza!"],["Tardis", "Cógela que nunca se sabe cuando vendrá bien un buen Whisky!"],[OBJECT, cup]]
	},
	"McMoon" : {
		"start" : [["Tardis", "Un McMoon"],["Alex", "Que sí pesado!"]]
	},
	"Vitrina1" : {
		"start" : [["Tardis", "Hermano mayor pegando 1"],["Alex", "Que sí pesado!"]]
	},
	"Vitrina2" : {
		"start" : [["Tardis", "Hermano mayor pegando 2"],["Alex", "Que sí pesado!"]]
	},
	"Vitrina3" : {
		"start" : [["Tardis", "Hermano mayor pegando 3"],["Alex", "Que sí pesado!"]]
	},
	"Cuadro1" : {
		"start" : [["Tardis", "Hermano mayor pegando 1"],["Alex", "Que sí pesado!"]]
	},
	"Cuadro2" : {
		"start" : [["Tardis", "Hermano mayor pegando 2"],["Alex", "Que sí pesado!"]]
	},
	"Cuadro3" : {
		"start" : [["Tardis", "Hermano mayor pegando 3"],["Alex", "Que sí pesado!"]]
	},
	"Window" : {
		"start" : [["Tardis", "Window"],["Alex", "Que sí pesado!"]]
	},
	"DownFloor" : {
		"start" : [["Tardis", "DownFloor"],["Alex", "Que sí pesado!"]]
	},
	"InterruptorBox" : {
		"start" : [["Alex", "Esto seguro que se puede arreglar"],["Tardis", "Si lo consigues podrías abrir esa puerta!"], ["Alex", "Me falta un cable, un engranaje y un chip"]]
	}
}

onready var left_portrait: = $text_box/left_portrait
onready var right_portrait: = $text_box/right_portrait
onready var rich_text := $text_box/text

func _ready() -> void:
	Global.connect("start_dialog",self,"start_dialog")


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("next_dialog"):
		next_dialog()



func start_dialog(node_label : String, status) -> void:
	print("Start_dialog " + node_label)
	#var status = get_status(node_label)
	current_dialog = dialog_dictionary[node_label][status]
	show_dialog()
	next_dialog()

func get_status(node_label : String) -> String:
	return "without_keys"
	
	
func next_dialog() -> void:
	if text_count == current_dialog.size():
		hide_dialog()
		return

	var current_text_to_show : Array = current_dialog[text_count]
	var i
	if current_text_to_show[0] == OBJECT:
		inventory.add_item(current_text_to_show[1])
		if current_text_to_show.size() > 2:
			set_status(current_text_to_show,2)
		text_count += 1
	if current_text_to_show[0] == NEXT_STATE:
		set_status(current_text_to_show,1)
		text_count += 1
	if text_count == current_dialog.size():
		hide_dialog()
		return
	var previous_character = current_character
	current_character = current_text_to_show[0]
	if current_character != previous_character:
		change_character()
	change_text(current_text_to_show[1])
	text_count += 1
	

func set_status(modifiers : Array, i) -> void:
	while i < modifiers.size():
		Global.status[modifiers[i]] = modifiers[i+1]
		i += 2


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
	emit_signal("hide_dialog")


func show_dialog() -> void:
	right_portrait.visible = false
	var label = current_dialog[0][0]
	if label == "Alex":
		left_portrait.texture = load(alex_portrait)
		right_portrait.texture = load(tardis_portrait)
		current_character = "Alex"
	elif label == "Tardis":
		left_portrait.texture = load(tardis_portrait)
		right_portrait.texture = load(alex_portrait)
		current_character = "Tardis"
	character_talking = SIDE.LEFT
	left_portrait.visible = true
	visible = true
	emit_signal("show_dialog")
		
		
		
		
		
		
		
		
	
