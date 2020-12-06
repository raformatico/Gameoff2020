extends Spatial

onready var smoke_particles : Particles = $smoke_particles

func _ready():
	if Global.status["Radio"] == "end2":
		enable_emitting()

func enable_emitting() -> void:
	smoke_particles.emitting = true
