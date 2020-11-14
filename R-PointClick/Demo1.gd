extends Spatial

onready var camera : Camera = $Camera
onready var marker : MeshInstance = $Marker
onready var raycast : RayCast = $Camera/RayCast

var position3 : Vector3 = Vector3.ONE
var click_position : Vector3 = Vector3.ONE

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		"""if event.button_index == BUTTON_LEFT and event.pressed:
			click_position = camera.project_local_ray_normal(event.position)
			print("\n\nproject_local_ray_normal")
			print(click_position)
			click_position = camera.project_position(event.position, 50)
			print("project_position")
			print(click_position)
			click_position = camera.project_ray_origin(event.position)
			print("project_ray_origin")
			print(click_position)
			click_position = camera.project_ray_normal(event.position)
			print("project_ray_normal")
			print(click_position)
			
			marker.transform.origin = click_position
		if event.button_index == BUTTON_RIGHT and event.pressed:
			var click_position := camera.project_local_ray_normal(event.position)
			print(position3)
			position3 -= Vector3(1,0,1)
			marker.transform.origin = position3	"""
		if event.button_index == BUTTON_LEFT and event.pressed:
			raycast.cast_to = camera.project_position(event.position, 50)
			click_position = raycast.get_collision_point()
			print("\n\nproject_local_ray_normal")
			marker.transform.origin = position3
			
func _on_StaticBody_input_event(camera: Node, event: InputEvent, click_position: Vector3, click_normal: Vector3, shape_idx: int) -> void:
	pass
	"""
	if event is InputEventMouseButton and event.pressed:
		$Marker.transform.origin = click_position
		print("CLICK STATIC")
		print(click_position)
		$Player.target = click_position
		#$Player.target = click_position"""
