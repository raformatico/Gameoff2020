extends Node

signal start_dialog(object_name, status)
signal start_dialog_item(object_name, status, item_selected, interactions)
signal breakMoonba

signal coffee_served()

var entrance_gateway="Main"

var changing_scenario = false
var debug: = false
var item_selected = null setget set_item_selected
var inventory_res : Inventory = preload("res://Inventory/inventory.tres")

var saved_position=null
var saved_rotation=null

var status_database = {
	"Statue" : ["start","read1","read2"],
	"Wax1" : ["start"],
	"Wax2" : ["start"],
	"Wax3" : ["start"],
	"Wax4" : ["start"],
	"Wax5" : ["start"],
	"Cup" : ["start"],
	"McMoon" : ["start"],
	"Vitrina1" : ["start"],
	"Vitrina2" : ["start"],
	"Vitrina3" : ["start"],
	"Cuadro1" : ["start"],
	"Cuadro2" : ["start"],
	"Cuadro3" : ["start"],
	"Window" : ["start"],
	"DownFloor" : ["start"],
	"InterruptorBox" : ["start", "with_wire", "with_gear", "with_chip", "with_everythin"],
}

var status = {
	"Statue" : "start",
	"Wax1" : "start",
	"Wax2" : "start",
	"Wax3" : "start",
	"Wax4" : "start",
	"Wax5" : "start",
	"Cup" : "start",
	"McMoon" : "start",
	"Vitrina1" : "start",
	"Vitrina2" : "start",
	"Cube027" : "start",
	"Cuadro1" : "start",
	"Cuadro2" : "start",
	"Cuadro3" : "start",
	"Window" : "start",
	"DownFloor" : "start",
	"InterruptorBox" : "start",
	"Lever" : "start",
	"Door" : "start",#CHANGE TO opened to enter
	"Pump" : "start",
	"Audrey" : "start",
	"Key" : "start",
	"Key2" : "start",
	"Plant" : "start",
	"Lamp" : "start",
	"Wire" : "start",
	"Gofrera" : "start",
	"Aspiradora" : "cafeteria",
	"AspiradoraHall" : "start",#CHANGE TO opened to enter
	"Cafetera" : "start",
	"Radio" : "start",
	"chip" : "start",
	"gear" : "start",
	"wire" : "start",
	"Error" : "start"
}

var interactions := {
	"cup" : "Cafetera",
	"wax" : "Gofrera",
	"cupcoffee" : "Pump",
	"gear" : "gear",
	"wire" : "wire",
	"chip" : "chip"
}


func set_item_selected(item_name) -> void:
	item_selected = item_name
	print(item_name)
	

func _on_Alex_arrived(object) -> void:
	if item_selected != null:
		emit_signal("start_dialog_item",object, status[object.name], item_selected, interactions[item_selected])
	elif object.name in status:
		emit_signal("start_dialog",object, status[object.name])
	

func _on_start_action(object, action : String) -> void:
	print("START ACTION")
	print(object)
	print(action)
	if action == "minigame":
		#TODO lanzar juego
		print("LANZAR MINIJUEGO")
		save_position()
		get_tree().change_scene("res://J-dj/DJTest2.tscn")
	elif action == "endgame":
		var fade_anim : AnimationPlayer = get_node("/root/maindoorpanel/Fade/fade_anim")
		fade_anim.play("fadeout")
		yield(fade_anim,"animation_finished")
		get_tree().change_scene("res://Scenes/end/end.tscn")
	elif action == "goingup":
		#TODO animación de la planta y caída del cable
		print("ANIMACION PLANTA")
	elif action == "panel":
		save_position()
		get_tree().change_scene("res://Scenes/maindoorpanel/maindoorpanel.tscn")
	elif action == "is_everything_connected":
		var connected = true
		if Global.status["chip"] != "connected":
			connected = false
		if Global.status["gear"] != "connected":
			connected = false
		if Global.status["wire"] != "connected":
			connected = false
		if connected:
			get_tree().change_scene("res://Scenes/museum-prefinal/Room.tscn")
			#status["InterruptorBox"] = "opendoor"
			#emit_signal("start_dialog","InterruptorBox", status["InterruptorBox"])
	elif action == "code":
		#TODO lanzar escena introducir código y 
		#que al final si se hace bien ejecute lo de abajo
		save_position()
		get_tree().change_scene("res://Scenes/DoorCode/doorcode.tscn")
#		if status["Door"] == "opened":
#			for child in object.get_parent().get_children():
#				if child.name == "2CpuertaR" or child.name == "2CpuertaL":
#					child.queue_free()
#
#			object.queue_free()
#			status["Door"] = "opened"
		pass
	elif action == "opened":
		audio_player.play_water()
	elif action == "hide":
		object.take()
	elif action == "use":
		inventory_res.del_item(object)
		
		match object:
			"cupcoffee":
				emit_signal("coffee_served")

func is_visible(object_name) -> bool:
	var is_visible = true
	if object_name == "Door" and status["Door"] == "opened":
		print("ESCONDETE")
		is_visible = false
	elif object_name == "AspiradoraHall" and status["AspiradoraHall"] == "opened":
		print("ESCONDETE")
		is_visible = false
	elif object_name == "Aspiradora" and status["Aspiradora"] == "end":
		print("FIN DE LA ASPIRADORA")
		is_visible = false
	elif object_name in status:
		if status[object_name] == "picked":
			is_visible = false
	return is_visible


var gateways={
	"hall2cafeteria"  : {"scene": "res://Scenes/cafeteria/room.tscn", "gateway":"cafeteria2hall", "status":"closed"},
	"greenhouse2hall" : {"scene" : "res://Scenes/museum-final/Room.tscn", "gateway":"hall2greenhouse", "status":"open"},
	"cafeteria2hall"  : {"scene" : "res://Scenes/museum-final/Room.tscn", "gateway":"hall2cafeteria","status":"open"},
	"hall2greenhouse" : {"scene" : "res://Scenes/greenhouse-final/Room.tscn", "gateway":"greenhouse2hall","status":"closed"},
	"Main"            : {"scene" : "res://Scenes/museum-final/Room.tscn", "gateway":"Main", "status":"open"}
}

func gateway_entered(gateway_name):
	var scene=gateways[gateway_name].scene
	if scene!=null and scene!="":
		
		entrance_gateway=gateways[gateway_name].gateway
		saved_position=null
		
		get_tree().change_scene (scene)
	
func get_gateway():
	return entrance_gateway
	
func save_position():
	saved_position=get_node("../Room").get_position()
	saved_rotation=get_node("../Room").get_rotation()
	
func restore_position(scene):
	return saved_position
