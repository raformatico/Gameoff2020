extends Spatial

onready var camera : Camera = $Camera
onready var marker : MeshInstance = $Marker
onready var player : KinematicBody = $Navigation/Player

func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var click_position := camera.project_ray_origin(event.position)
			print(click_position)
			marker.transform.origin = click_position
			player.target = click_position
			
