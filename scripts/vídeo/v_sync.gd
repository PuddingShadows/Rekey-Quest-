extends CheckButton

var timer = 0.0

func _process(delta):
	timer += delta
	if timer >= 1.0:
		#print("FPS Atual: ", Engine.get_frames_per_second())
		timer = 0.0

func _ready():
	# Tenta remover o limite de FPS do motor
	Engine.max_fps = 0 
	var vsync_mode = DisplayServer.window_get_vsync_mode()
	var is_vsync_on = vsync_mode != DisplayServer.VSYNC_MAILBOX
	set_pressed_no_signal(is_vsync_on)


func _on_toggled(_button_pressed: bool):
	if button_pressed:
		# Ativa o VSync padrão (Sincronia vertical ligada)
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		#print("VSync Ativado")
	else:
		# Desativa o VSync (Pode causar screen tearing, mas libera o FPS)
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_MAILBOX)
		#print("VSync Desativado")
