extends MeshInstance


onready var tween : Tween = get_node("Tween")
onready var smoke = get_node("smoke")
var broken := false

func _ready():
	broken=Global.broken_aspiradora
	if not broken:
		tween.interpolate_property(get_node(".."), "unit_offset",
			0, 1, 10,
			Tween.TRANS_QUAD , Tween.EASE_IN_OUT)
		tween.start()
	else:
		get_node("..").unit_offset = 0
		visible=false

func brokeMoonba() -> void:
	broken = true
	Global.broken_aspiradora=true
	visible=false
