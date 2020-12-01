extends MeshInstance


onready var tween : Tween = get_node("Tween")


func _ready():
	connect("breakMoonba",Global,"on_brokenMoonba")
	tween.interpolate_property(get_node(".."), "unit_offset",
		0, 1, 10,
		Tween.TRANS_QUAD , Tween.EASE_IN_OUT)
	tween.start()


func on_brokenMoonba() -> void:
	print("BROKEN")
	tween.stop_all()
	get_node("..").unit_offset = 0

