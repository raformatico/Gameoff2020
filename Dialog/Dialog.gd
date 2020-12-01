extends Control

signal show_dialog
signal hide_dialog
signal start_action

const ACTION = "ACTION"
const OBJECT = "OBJECT"
const NEXT_STATE = "NEXT_STATE"
enum SIDE {LEFT, RIGHT}

var tardis_portrait = "res://Dialog/assets/Tardi-dia.png"
var alex_portrait = "res://Dialog/assets/Player-dia.png"
var item_used = null
var inventory = load("res://Inventory/inventory.tres")
var character_talking : int = SIDE.LEFT
var current_character := "Alex"
var current_dialog : Array
var current_object
var text_count := 0





var dialog_dictionary = {
	"Statue" : {
		"start" : [["Alex","Me recuerda a la foto de la navidad pasada que nos hicieron a mi hermano y a mi en el centro comercial."],["Tardis","Debe de rememorar algo muy importante para que esté en el centro de esta sala."],[NEXT_STATE,"Statue","read1"]],
		"read1" : [["Tardis", "Seguro que se nos pasa algo por alto."],["Alex", "Aquí hay algo escrito... Primer hermano en la luna... 1969..."],["Tardis","Eso parece una fecha"],[NEXT_STATE,"Statue","read2"]],
		"potion" : [["Alex", "He usado la poción con la estatua!"],[NEXT_STATE,"Statue","read2"], [ACTION,"potion","use"]],
		"read2" : [["Alex", "¿Cuál era la fecha que ponía aquí?"],["Tardis", "1984..."]]
	},
	"Wax1" : {
		"start" : [["Alex","Tenía unas ceras iguales en casa. ¡Me las quedo!"], ["Tardis", "Ten cuidado que son bastante blandas y se te pueden derretir en el bolsillo."], ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","¡Otra cera! ¡A la colección!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","Vas a dejar el suelo mucho más limpio."], ["Alex","Tengo alma de coleccionista"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax2" : {
		"start" : [["Alex","Tenía unas ceras iguales en casa. ¡Me las quedo!"], ["Tardis", "Ten cuidado que son bastante blandas y se te pueden derretir en el bolsillo."], ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","¡Otra cera! ¡A la colección!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","Vas a dejar el suelo mucho más limpio."], ["Alex","Tengo alma de coleccionista"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax3" : {
		"start" : [["Alex","Tenía unas ceras iguales en casa. ¡Me las quedo!"], ["Tardis", "Ten cuidado que son bastante blandas y se te pueden derretir en el bolsillo."], ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","¡Otra cera! ¡A la colección!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","Vas a dejar el suelo mucho más limpio."], ["Alex","Tengo alma de coleccionista"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax4" : {
		"start" : [["Alex","Tenía unas ceras iguales en casa. ¡Me las quedo!"], ["Tardis", "Ten cuidado que son bastante blandas y se te pueden derretir en el bolsillo."], ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","¡Otra cera! ¡A la colección!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","Vas a dejar el suelo mucho más limpio."], ["Alex","Tengo alma de coleccionista"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax5" : {
		"start" : [["Alex","Tenía unas ceras iguales en casa. ¡Me las quedo!"], ["Tardis", "Ten cuidado que son bastante blandas y se te pueden derretir en el bolsillo."], ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked"]],
		"picked1" : [["Alex","¡Otra cera! ¡A la colección!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked"]],
		"picked2" : [["Tardis","Vas a dejar el suelo mucho más limpio."], ["Alex","Tengo alma de coleccionista"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked"]],
		"picked" : []
	},
	"Cup" : {
		"start" : [["Alex", "Mira, una taza. Esta me la quedo..."],["Tardis", "No puedo contener la emoción."],["Alex","*&@$#/°s"],[OBJECT, inventory.cup], [ACTION, "current", "hide"],[NEXT_STATE, "Cup", "picked"]],
		"picked" : []
	},
	"McMoon" : {
		"start" : [["Alex", "Mi padre se pasaba el día sentado frente a uno de estos."],["Tardis", "Espero que el suyo funcionase..."]]
	},
	"Vitrina1" : {
		"start" : [["Alex", "No sé muy bien qué será esto."]]
	},
	"Vitrina2" : {
		"start" : [["Alex", "No sé muy bien qué será esto."]]
	},
	"Vitrina3" : {
		"start" : [["Alex", "No sé muy bien qué será esto."]]
	},
	"Cuadro1" : {
		"start" : [["Tardis", "Vaya cuadros más frikis. Qué mal gusto."]]
	},
	"Cuadro2" : {
		"start" : [["Tardis", "Vaya cuadros más frikis. Qué mal gusto."]]
	},
	"Cuadro3" : {
		"start" : [["Tardis", "Vaya cuadros más frikis. Qué mal gusto."]]
	},
	"Window" : {
		"start" : [["Tardis", "Window"],["Alex", "Que sí pesado!"]]
	},
	"DownFloor" : {
		"start" : [["Tardis", "DownFloor"],["Alex", "Que sí pesado!"]]
	},
	"InterruptorBox" : {
		"start" : [["Alex", "Este panel no funciona, da un mensaje de error..."],["Tardis", "Creo que faltan algunos componentes, si los encontramos seguro que podemos abrir esta puerta."]],
		"withoutwire" : [["Alex","Aquí encajaría un cable."],["Tardis","Chico listo."]],
		"withoutgear" : [["Alex","Qué forma más extraña, parece que falta un engranaje o alguna pieza circular"],["Tardis","Pues a seguir buscando..."]],
		"withoutchip" : [["Alex","No sé de donde vamos a sacar un chip de última generación, que claramente es lo que falta en este panel."],["Tardis","Parece que lo sabes todo."]],
		"connectwire" : [["Alex","Este cable conecta perfecto. Una cosa menos."]],
		"connectgear" : [["Alex","Esto es muy raro"],["Tardis","Funciona, así que no te preguntes por qué"]],
		"connectchip" : [["Alex","¡Encaja!"],["Tardis","Es que es un chip de última generación."]],
		"opendoor" : [["Alex", "¡Lo hemos conseguido, la puerta está abierta!"],["Tardis","Yo no estaría muy contento sabiendo lo que te espera en esa habitación."],[ACTION,"door", "open"]]
		
	},
	"Lever" : {
		"start" : [["Tardis", "Y se hizo la luz..."],["Alex", "Qué mal rollo de sitio."],[ACTION, "current", "lighton"],[NEXT_STATE,"Lever", "poweron"]],
		"poweron" : [["Tardis", "Luces fuera"],["Alex", "Bonitas vistas. Echo de menos la tierra"],[ACTION, "current", "lightoff"],[NEXT_STATE,"Lever", "poweroff"]],
		"poweroff" : [["Alex", "Dejemos las luces encendidas."],["Tardis", "Sí, más vale que veamos por dónde vamos."],[ACTION, "current", "lighton"],[NEXT_STATE,"Lever", "poweron"]]
	},
	"Updoor" : {
		"start" : [["Alex","Parece que necesitamos un código de 4 dígitos "],["Tardis","Creo que he visto unos números en algún lado..."]],
		"opendoor" : [["Alex","¡Puerta abierta!"],["Tardis","Espero que sigas a salvo al cruzarla..."]]
	},
	"DigitCode" : {
		"start" : [["Alex","Parece que necesitamos un código de 4 dígitos"],["Tardis", "Creo que he visto unos números en algún lado..."]],
		"opened" : [["Alex","¡Puerta abierta!"],["Tardis", "Espero que sigas a salvo al cruzarla..."]]
	},
	"Pump" : {
		"start" : [["Alex","Me está entrando algo de sed."],["Tardis", "Creo que sólo puedes verter algún líquido, no extraerlo..."]],
		"coffe" : [["Alex","Voy a probar a diluir  un poco de café en el depósito."],["Tardis", "Mientras no te lo bebas tú..."]]
	},
	"Audrey" : {
		"start" : [["Alex",""],["Tardis", ""],["Alex",""],["Tardis", ""]]
	},
	"Key" : {
		"start" : [["Alex","Uff me ha costado abrir esta llave."],["Tardis", "Quizá deberías hacer más pesas."],["Alex","¡Mira! hemos abierto el caudal de regadío. Aunque a la planta no parece importarle demasiado"],["Tardis", "Solamente con agua no vas a conseguir reanimar a esa grandullona."]],
		"coffe" : [["Tardis", "Eso es, un poco de café por la mañana ayuda a cualquiera a levantarse."]]
	},
	"Key2" : {
		"start" : [["Alex","Esta llave ya no gira más."],["Tardis", "Creo que la has roto... De hecho suena agua en la cafetería."],["Alex","Ups"],[NEXT_STATE,"Key2","opened"]],
		"opened" : [["Tardis", "No lo intentes que esta llave ya no vuelve a su sitio..."]]
	},
	"Plant" : {
		"start" : [["Alex","Qué planta más curiosa."],["Tardis", "¡Cuidado! creo que es carnívora...Estoy bromeando"],["Alex","No es gracioso, quizá pueda usarla para subir."]],
		"goingup" : [["Tardis", "Ya puedes subir."],["Alex","¿Un poco obvio no?"]]
	},
	"Lamp" : {
		"start" : [["Alex","Tengo que intentar llegar allí arriba."],["Tardis", "Quizá te salgan alas..."]],
		"plant" : [["Tardis", "Eso es, tira un poco más, ya falta poco."],["Alex","Me caig..."],["Tardis", "¿Estás bien?"], ["Alex","Sí, gracias por tu ayuda."],["Tardis","¡Oye… genero luz y oxígeno, pero no me pidas que sostenga 40 kilos de imberbe terrestre!"]]
	},
	"Wire" : {
		"start" : [["Alex","Creo que esto me va a servir."],["Tardis", "Ten cuidado, no vaya a tener que salvarte de nuevo."]],
		"picked" : []
	},
	"Gofrera" : {
		"start" : [["Alex","Esto está caliente, podría cocinar algo."],["Tardis", "Espero que sepas lo que estás haciendo...esa máquina lleva tiempo sin usarse."]],
		"addwax" : [["Tardis", "¿Qué guarrería estás haciendo?"],["Alex","Calla, creo que puede funcionar."],["Tardis", "Espero que no pienses en comerte esa cosa circular."]]
	},
	"Aspiradora" : {
		"start" : [["Alex","Mira qué robot limpiador más bonito. Cuchi, cuchi..."],["Tardis", "¡Retrocede! Se vuelven muy territoriales cuando no tienen trabajo, esa zona está vedada."],["Alex",""],["Tardis", ""]],
		"cafeteria" : [["Tardis","Ahora parece que no se preocupa mucho de ti"],["Alex", "Sí, pero da buenos empujones y no hay manera de revisar si tiene algo que nos venga bien..."], ["Tardis","Perdona, estás hablando de un ser vivo."]],
		"end" : [["Alex","Anda mira! Tiene un chip que seguro que nos viene bien."],["Tardis","Saquea muertos! Eres horrible... Bueno qué se le va a hacer. Descanse en paz"]]
	},
	"Cafetera" : {
		"start" : [["Alex","Esto aún funciona"],["Tardis", "Te vas a quemar"],["Alex","Tienes razón"], [NEXT_STATE,"Cafetera","start2"]],
		"start2" : [["Alex","Quizá si encontrásemos algo donde servir el café."]],
		"addcup" : [["Tardis", "No me bebería eso ni aunque me pagaran."],["Alex","Seguro que puede sernos de utilidad."],["Tardis", "Sin duda eso es energía concentrada!"]]
	},
	"Radio" : {
		"start" : [["Alex","Esta radio no funciona del todo bien pero creo que puedo arreglarla"],["Tardis", "Inténtalo que me encanta la música"]],
		"middle" : [["Alex","Mira, le gusta esta melodía"],["Tardis", "Juraría que está intentando bailar... ¡con un ritmo pésimo, por cierto! "]],
		"end" : [["Tardis", "Creo que se está volviendo loca."],["Alex", "Cuidado ¡va a estallar!"]]
	},
	"Error" : {
		"start" : [["Alex","No creo que pueda usar eso aquí"],["Tardis","Era tu idea, no la mía..."], [NEXT_STATE, "Error","start2"]],
		"start2" : [["Tardis","Esto es probar por probar, ¿verdad?"],[NEXT_STATE, "Error", "start"]]
	}
	
}

onready var left_portrait: = $text_box/left_portrait
onready var right_portrait: = $text_box/right_portrait
onready var right_background := $background_right
onready var left_background := $background_left
onready var rich_text := $text_box/text

func _ready() -> void:
	Global.connect("start_dialog",self,"start_dialog")
	Global.connect("start_dialog_item",self,"start_dialog_item")
	connect("start_action",Global,"_on_start_action")


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("next_dialog"):
		next_dialog()

func start_dialog_item(object, status, item_selected, interact_with) -> void:
	item_used = item_selected
	#Show generic misselection of item
	if object.name != interact_with:
		current_dialog = dialog_dictionary["Error"][Global.status["Error"]]
		show_dialog()
		next_dialog()
	#Else show correct dialog
	else:
		Global.status[object.name] = item_selected
		start_dialog(object, item_selected)
	#Deselect item
	inventory.emit_signal("deselect_all")
	

func start_dialog(object, status) -> void:
	current_dialog = dialog_dictionary[object.name][status]
	current_object = object
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
		text_count += 1
	elif current_text_to_show[0] == ACTION:
		if current_text_to_show[1] == "current":
			emit_signal("start_action", current_object, current_text_to_show[2])
		else:
			emit_signal("start_action", current_text_to_show[1], current_text_to_show[2])
		text_count += 1
	elif current_text_to_show[0] == NEXT_STATE:
		set_status(current_text_to_show[1],current_text_to_show[2])
		text_count += 1
	else:
		var previous_character = current_character
		current_character = current_text_to_show[0]
		if current_character != previous_character:
			change_character()
		change_text(current_text_to_show[1])
		text_count += 1
		return
	
	if text_count == current_dialog.size():
		hide_dialog()
	else:
		next_dialog()

func set_status(object : String, new_status : String) -> void:
	if Global.status[object] != "picked":
		Global.status[object] = new_status


func change_character() -> void:
	if character_talking == SIDE.LEFT:
		left_portrait.visible = false
		left_background.visible = false
		right_portrait.visible = true
		right_background.visible = true
		character_talking = SIDE.RIGHT
	else:
		left_portrait.visible = true
		left_background.visible = true
		right_portrait.visible = false
		right_background.visible = false
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
		
		
func _on_Dialog_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		next_dialog()
		
		
		
		
		
	



