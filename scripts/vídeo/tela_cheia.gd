extends CheckButton


func _process(_delta: float) -> void:
	var is_fullscreen = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	set_pressed_no_signal(is_fullscreen)

func _on_toggled(_button_pressed: bool):
	if button_pressed:
		# Ativa Tela Cheia
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		# Volta para modo Janela
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
