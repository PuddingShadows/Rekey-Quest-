extends Area2D

@onready var SFX_open = $SFX_open
@onready var SFX_select = $SFX_select

var has_fade = false
var player_in = false
var fade_done = false


func _process(_delta: float) -> void:
	if Globals.portas["porta_mundo1"]:
		$porta_aberta.visible = true
		if has_fade == false:
			$fade_portas.play("fade_in")
			has_fade = true
	else:
		$porta_aberta.visible = false
		$porta.visible = true
		$porta.modulate.a = 1
		
	if Input.is_action_just_pressed("interact") and player_in and fade_done:
		SFX_select.play()
		Transition.trocar_de_cena("res://lobbies/lobby_mundo_1.tscn")
		Globals.save_game()

func _on_fade_portas_animation_finished(_anim_name: StringName) -> void:
		$porta.visible = false
		fade_done = true


func anim_fade_in():
	var ui_select_button = get_tree().root.get_node("Lobby_principal/controls/ui_interect")
	var anim_btn = get_tree().root.get_node("Lobby_principal/controls/anim")
	
	
	if not anim_btn.is_playing():
		ui_select_button.visible = true
		anim_btn.play("fade_in")
	else:
		await anim_btn.animation_finished
		ui_select_button.visible = true
		anim_btn.play("fade_in")

func anim_fade_out():
	var ui_select_button = get_tree().root.get_node("Lobby_principal/controls/ui_interect")
	var anim_btn = get_tree().root.get_node("Lobby_principal/controls/anim")
	
	if not anim_btn.is_playing():
		anim_btn.play("fade_out")
	else:
		await anim_btn.animation_finished
		anim_btn.play("fade_out")
	
	await anim_btn.animation_finished
	ui_select_button.visible = false

func _on_body_entered(_body: Node2D) -> void:
	player_in = true
	
	
	if Globals.chaves["chave_mundo1"] or Globals.portas["porta_mundo1"]:
		$Label.visible = true
		
		if not $anim.is_playing():
			$anim.play("fade_in")
		
		if !Globals.portas["open_play1"]:
			SFX_open.play()
			Globals.portas["open_play1"] = true
		anim_fade_in()
		Globals.portas["porta_mundo1"] = true
		Globals.chaves["chave_mundo1"] = false
		Globals.chaves["chave_mundo1_hud"] = false
		Globals.chaves["chave_usada1"] = true
		
		Globals.save_game()
	else:
		$trancado.visible = true
		
		if not $anim.is_playing():
			$anim.play("fade_in")

func _on_body_exited(_body: Node2D) -> void:
	player_in = false
	
	anim_fade_out()
	
	if not $anim.is_playing():
		$anim.play("fade_out")
	
	await $anim.animation_finished
	$trancado.visible = false
	$Label.visible = false
