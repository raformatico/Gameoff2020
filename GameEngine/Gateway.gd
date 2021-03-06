extends Area

signal gateway_entered(gateway)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var gateway_name="door"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("gateway_entered",Global,"gateway_entered")

	if Global.gateways[gateway_name].status=="opening":
		Global.gateways[gateway_name].status="open"
		for door in get_children():
			if door.get_class()=="StaticBody" and door.is_in_group("Door"):
				door.open()	
	elif Global.gateways[gateway_name].status=="open":
		for door in get_children():
			if door.get_class()=="StaticBody" and door.is_in_group("Door"):
				door.set_open()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Gateway_body_entered(body):
	if body.is_in_group("Character"):
		emit_signal("gateway_entered",gateway_name)
