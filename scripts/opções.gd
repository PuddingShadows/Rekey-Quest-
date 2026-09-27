extends Control

@onready var SFX_select = $SFX_select
@onready var SFX_reset = $SFX_reset

func _ready() -> void:
	await get_tree().process_frame
		
	# Puxa os dados que o Autoload já carregou
	var d = ConfigGlobal.dados
	
	# Ajusta os botões visualmente sem disparar o erro de 'null'
	%tela_cheia.set_pressed_no_signal(d.fullscreen)
	%VSync.set_pressed_no_signal(d.vsync)
	%viewport.set_pressed_no_signal(d.tela)
	
	ConfigGlobal.configuracoes_atualizadas.connect(sincronizar_ui)
	sincronizar_ui()

func _process(_delta: float) -> void:
	pass


func _on_voltar_pressed() -> void:
	SFX_select.play()
	ConfigGlobal.carregar_do_disco()
	
	# Atualiza os botões visualmente para não ficarem "mentindo"
	%tela_cheia.set_pressed_no_signal(ConfigGlobal.dados.fullscreen)
	%VSync.set_pressed_no_signal(ConfigGlobal.dados.vsync)
	%viewport.set_pressed_no_signal(ConfigGlobal.dados.tela)
	if ConfigGlobal.dados.tela:
		%viewport.button_pressed = true
	else:
		%canvas_layer.button_pressed = true
	
	if !Globals.in_menu:
		Transition.trocar_de_cena("res://scenes/menu.tscn")
	else:
		Transition.anim.play("fade_in")
		queue_free()
		Globals.in_menu = false

func _on_voltar_jogo_pressed() -> void:
	SFX_select.play()
	$"opções".visible = true
	$jogo_group.visible = false
	$jogo_group/reset_texto2.visible = false
	$jogo_group/reset.visible = true
	ConfigGlobal.carregar_do_disco()
		
			# Atualiza os botões visualmente para não ficarem "mentindo"
	%tela_cheia.set_pressed_no_signal(ConfigGlobal.dados.fullscreen)
	%VSync.set_pressed_no_signal(ConfigGlobal.dados.vsync)
	%viewport.set_pressed_no_signal(ConfigGlobal.dados.tela)
	
	if ConfigGlobal.dados.tela:
		%viewport.button_pressed = true
	else:
		%canvas_layer.button_pressed = true

func _on_voltar_video_pressed() -> void:
	SFX_select.play()
	$"opções".visible = true
	$video.visible = false
	ConfigGlobal.carregar_do_disco()

func _on_voltar_audio_pressed() -> void:
	SFX_select.play()
	$"opções".visible = true
	$audio.visible = false
	ConfigGlobal.carregar_do_disco()

func _on_voltar_controles_pressed() -> void:
	SFX_select.play()
	$"opções".visible = true
	$controles.visible = false
	$controles/ContentHolder/controle_mobile/editar_mobile.visible = true
	$controles/ContentHolder/erro.visible = false


func _on_jogo_pressed() -> void:
	SFX_select.play()
	$"opções".visible = false
	$jogo_group.visible = true

func _on_reset_pressed() -> void:
	SFX_select.play()
	if !Globals.in_menu:
		$jogo_group/reset.visible = false
		$jogo_group/voltar_jogo.visible = false
		
		$jogo_group/reset_texto.visible = true
		$jogo_group/sim.visible = true
		$jogo_group/"não".visible = true
	else:
		$jogo_group/reset_texto2.visible = true
		$jogo_group/reset.visible = false

func _on_não_pressed() -> void:
	SFX_select.play()
	
	$jogo_group/reset.visible = true
	$jogo_group/voltar_jogo.visible = true
	
	$jogo_group/reset_texto.visible = false
	$jogo_group/sim.visible = false 
	$jogo_group/"não".visible = false

func _on_sim_pressed() -> void:
	Globals.reset_save()
	ConfigGlobal.dados.layout = {}
	ConfigGlobal.salvar_no_disco()
	var dir = DirAccess.open("user://")
	if dir.file_exists("config.cfg"):
		dir.remove("config.cfg")
		#print("config.cfg apagado!")
	Transition.trocar_de_cena("res://scenes/menu.tscn")
	SFX_reset.play()
	await get_tree().process_frame
	get_tree().reload_current_scene()


func _on_video_pressed() -> void:
	SFX_select.play()
	$"opções".visible = false
	$video.visible = true

func _on_iluminação_slider_value_changed(value: int) -> void:
	var t = pow(value / 100.0, 1.5)
	var convertido = lerp(0.6, 1.4, t)
	%"iluminação_porcentagem".text = str(int(value)) + "%"
	EnvironmentManager.get_node("WorldEnvironment").color = Color(convertido, convertido, convertido, 1)


func _on_audio_pressed() -> void:
	SFX_select.play()
	$"opções".visible = false
	$audio.visible = true

func _on_volume_geral_value_changed(value: float) -> void:
	%vol_geral_porcentagem.text = str(int(value)) + "%"
	
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, percent_to_db(value))

func percent_to_db(value: float) -> float:
	if value <= 0:
		return -80
	return linear_to_db(value / 100.0)

func _on_volume_geral_drag_ended(value_changed: bool) -> void:
	if value_changed:
		SFX_select.play()

func _on_efeitos_sonoros_value_changed(value: float) -> void:
	%SFXs_porcentagem.text = str(int(value)) + "%"
	
	var bus_index = AudioServer.get_bus_index("sfx")
	AudioServer.set_bus_volume_db(bus_index, percent_to_db(value))

func _on_efeitos_sonoros_drag_ended(value_changed: bool) -> void:
	if value_changed:
		SFX_select.play()


func _on_controles_pressed() -> void:
	SFX_select.play()
	$"opções".visible = false
	$controles.visible = true

func _on_editar_mobile_pressed() -> void:
	SFX_select.play()
	if !Globals.in_menu:
		Globals.editing = true
		Transition.trocar_de_cena("res://scenes/controls.tscn")
	else:
		$controles/ContentHolder/controle_mobile/editar_mobile.visible = false
		$controles/ContentHolder/erro.visible = true


const SAVE_PATH = "user://config.cfg"

func salvar_tudo():
	var novos_dados = {
		"fullscreen": %tela_cheia.button_pressed,
		"vsync": %VSync.button_pressed,
		"tela": %viewport.button_pressed,
		"brilho": %"iluminação_slider".value,
		"vol_geral": %volume_geral.value,
		"sfx": %"efeitos sonoros".value,
	}
	
	ConfigGlobal.dados = novos_dados
	ConfigGlobal.salvar_no_disco()

func sincronizar_ui():
	var d = ConfigGlobal.dados
	
	%tela_cheia.set_pressed_no_signal(d.fullscreen)
	%VSync.set_pressed_no_signal(d.vsync)
	
	%"iluminação_slider".value = d.brilho
	%"iluminação_porcentagem".text = str(int(d.brilho)) + "%"
	
	%volume_geral.value = d.vol_geral
	%vol_geral_porcentagem.text = str(int(d.vol_geral)) + "%"
	
	%"efeitos sonoros".value = d.sfx
	%SFXs_porcentagem.text = str(int(d.sfx)) + "%"
	
	if d.tela:
		%viewport.button_pressed = true # Ativa o modo Pixel
	else:
		%canvas_layer.button_pressed = true   # Ativa o modo Normal
