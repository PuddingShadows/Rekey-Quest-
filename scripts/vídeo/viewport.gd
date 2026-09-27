extends CheckButton


func _ready() -> void:
	if get_tree().root.content_scale_mode == Window.CONTENT_SCALE_MODE_VIEWPORT:
		set_pressed_no_signal(true)

func _process(_delta: float) -> void:
	pass


func _on_toggled(ativo: bool) -> void:
	ConfigGlobal.dados["tela"] = button_pressed
	
	if ativo:
		get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
