extends Area2D

@onready var SFX_open = $SFX_open
@onready var SFX_star = $SFX_star
@onready var SFX_star_f = $SFX_star_fail
@onready var SFX_select = $SFX_select

var has_fade = false

func anim_fade_in():
	var anim_btn = get_tree().root.get_node("level04/controls/anim")
	var ui_select_button = get_tree().root.get_node("level04/controls/ui_interect")
	
	
	if not anim_btn.is_playing() and ui_select_button.visible == false:
		ui_select_button.visible = true
		anim_btn.play("fade_in")
	else:
		await anim_btn.animation_finished
		ui_select_button.visible = true
		anim_btn.play("fade_in")

func anim_fade_out():
	var anim_btn = get_tree().root.get_node("level04/controls/anim")
	var ui_select_buttcon = get_tree().root.get_node("level04/controls/ui_interect")
	
	if not anim_btn.is_playing():
		anim_btn.play("fade_out")
	else:
		await anim_btn.animation_finished
		anim_btn.play("fade_out")
	
	await anim_btn.animation_finished
	ui_select_buttcon.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.red_key:
		$porta_aberta.visible = true
		anim_fade_in()
		if not has_fade:
			$fade_porta.play("fade_in")
			SFX_open.play()
			has_fade = true
			await $fade_porta.animation_finished
			$porta.visible = false
			
	else:
		$porta.visible = true
		$porta_aberta.visible = false

func _on_body_exited(_body: Node2D) -> void:
	anim_fade_out()


func resetar_estrelas():
		for i in range(1, 4):
			$porta_concluida/painel/endpanel/container.get_node("estrela%d" % i).visible = false
			$porta_concluida/painel/endpanel/container.get_node("sem_estrela%d" % i).visible = true

func animar_estrela(numero: int, ganhou: bool):
	var base = $porta_concluida/painel
	
	var estrela = base.get_node("endpanel/container/estrela%d" % numero)
	var sem_estrela = base.get_node("endpanel/container/sem_estrela%d" % numero)
	var texto = base.get_node("texto%d" % numero)
	
	sem_estrela.visible = false
	estrela.visible = true
	estrela.scale = Vector2.ZERO
	
	texto.modulate = Color.WHITE
		
	var cor_texto := Color.RED
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	if ganhou:
		SFX_star.play()
		cor_texto = Color.GREEN
		
		# 0 -> 4.5
		tween.tween_property(estrela, "scale", Vector2(4.5, 4.5), 0.18)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
		
		# 4.5 -> 4.0
		tween.tween_property(estrela, "scale", Vector2(4.0, 4.0), 0.12)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
		
		tween.parallel().tween_property(
			texto,
			"modulate",
			cor_texto,
			0.25
			).set_ease(Tween.EASE_OUT)
	else:
		SFX_star_f.play()
		sem_estrela.visible = true
		estrela.visible = false
		
		tween.tween_property(
			texto,
			"modulate",
			Color.RED,
			0.25
			).set_ease(Tween.EASE_OUT)

func animar_estrelas_ganhas():
	var dados = [
		{ "num": 1, "ganhou": get_parent().star_time },
		{ "num": 2, "ganhou": get_parent().star_strawberry },
		{ "num": 3, "ganhou": get_parent().star_deaths }
		]
	for d in dados:
		await get_tree().create_timer(0.4).timeout
		animar_estrela(d.num, d.ganhou)

func star_verification():
	if get_parent().time <= 10.99:
		get_parent().star_time = true
	
	if get_parent().strawberry == true:
		get_parent().star_strawberry = true
	
	if get_parent().deaths <= 0:
		get_parent().star_deaths = true

func contar_estrelas():
	var total := 0
	
	if get_parent().star_time:
		total += 1
		
	if get_parent().star_strawberry:
		total += 1
		
	if get_parent().star_deaths:
		total += 1
		
	return total


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		
		star_verification()
		
		var estrelas = contar_estrelas()
		LobbyMundo1.salvar_estrelas("Stars_door4", estrelas)
		
		
		get_tree().paused = true
		$porta_concluida/painel/texto1.text = "tempo:
			" + str(get_parent().time_end)
		$porta_concluida/painel/texto3.text = str(get_parent().deaths_end) + " mortes"
		$porta_concluida.visible = true
		$anim.play("fade_slide")
		
		resetar_estrelas()
		await get_tree().create_timer(0.3).timeout
		animar_estrelas_ganhas()
		
		if not Globals.doors_by_world.has("LobbyMundo1"):
			Globals.doors_by_world["LobbyMundo1"] = {}
			
		Globals.doors_by_world["LobbyMundo1"]["Door4"] = true
		Globals.save_game()

func _ready() -> void:
	pass
