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

var potion = "potion"
var armor = "armor"



var dialog_dictionary = {
	"door_scene1" : {
		"without_keys" : [["Alex","No tengo las llaves"],["Tardis","Pues a por ellas campeón"],["Alex", "Ok"],[OBJECT, potion]],
		"with_keys" : [["Tardis", "Si no hubiera sido por mi no las habrías encontrado"],["Alex", "Gracias amiguito"]],
	},
	"Statue" : {
		"without_armor" : [["Alex","Este se parece a mi hermano"],["Tardis","Pues es el Gran hermano! Ponte una armadura para enfrentarte a él"],[NEXT_STATE,"Cube027","with_statue"]],
		"with_armor" : [["Tardis", "A por él!!!!!"],["Alex", "Lavin me lo he cargao!"],["Tardis", "Pues coge la poción y vete de aquí"],[OBJECT, potion, "Statue", "win_battle"]],
		"win_battle" : [["Tardis", "Pobrecito vaya paliza le diste"],["Alex", "La verdad es que sí, pobre"]]
	},
	"Cube027" : {
		"without_statue" : [["Tardis", "Aquí hay algo para protegerte"],["Alex","No me interesa..."]],
		"with_statue" : [["Alex","No me vendría mal la protección ahora..."],["Tardis", "Pues coge eso y póntelo de armadura"],[OBJECT, armor,"Statue","with_armor","Cube027","with_armor"]],
		"with_armor" : [["Alex","Qué solo está esto sin armadura..."]]
	}
}


onready var left_portrait: = $text_box/left_portrait
onready var right_portrait: = $text_box/right_portrait
onready var rich_text := $text_box/text

func _ready() -> void:
	Global.connect("start_dialog",self,"start_dialog")


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("next_song"):
		start_dialog("door_scene1","without_keys")
	if Input.is_action_just_pressed("next_dialog"):
		if visible == true:
			next_dialog()


func start_dialog(node_label : String, status) -> void:
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
		
		
		
		
		
		
		
		
	
