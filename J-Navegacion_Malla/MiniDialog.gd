extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var text=""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_text(text_):
	$Text.text=text_
	$Timer.start(5)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$Text.text=""
