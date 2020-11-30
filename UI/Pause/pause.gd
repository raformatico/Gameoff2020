extends Control

func _ready() -> void:
	$TextureButton.show()
	$pause_menu.hide()

func _on_TextureButton_pressed() -> void:
	get_tree().paused = true
	$ColorRect.show()
	$TextureButton.hide()
	$pause_menu.show()


func _on_continue_pressed() -> void:
	get_tree().paused = false
	$ColorRect.hide()
	$TextureButton.show()
	$pause_menu.hide()


func _on_exit_pressed() -> void:
	get_tree().quit()
