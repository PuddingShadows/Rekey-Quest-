extends Area2D

@onready var SFX_select = $SFX_select

var player_in = false
var player_inside = false

func anim_fade_in():
	var ui_select_button = get_tree().root.get_node("Lobby_principal/controls/ui_interect")
	var anim_btn = get_tree().root.get_node("Lobby_principal/controls/anim")
	
	
	if not anim_btn.is_playing() and ui_select_button.visible == false:
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
	if not player_inside:
		ui_select_button.visible = false
		player_in = false

func _on_body_entered(_body: Node2D) -> void:
	if Globals.tutoriais["tutorial01"]:
		anim_fade_in()
		player_inside = true
		
		player_in = true
		$tutorial.visible = true
		
		if not $anim.is_playing():
			$anim.play("fade_in")
		
		Globals.save_game()
	
	elif Globals.tutoriais["tutorial02"]:
		anim_fade_in()
		player_inside = true
		
		player_in = true
		
		if not $anim.is_playing():
			$anim.play("fade_in")
		
		Globals.save_game()
	
	else:
		$trancado.visible = true
		
		if not $anim.is_playing():
			$anim.play("fade_in")

func _on_body_exited(_body: Node2D) -> void:
	anim_fade_out()
	player_inside = false
	$"produção".visible = false
	
	if not $anim.is_playing():
		$anim.play("fade_out")
	
	await $anim.animation_finished
	$tutorial.visible = false
	$trancado.visible = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in:
		Globals.save_game()
		SFX_select.play()
	
		if Globals.tutoriais["tutorial01"]:
			Transition.trocar_de_cena("res://tutoriais/tutorial_1.tscn")
		elif Globals.tutoriais["tutorial02"]:
			#Transition.trocar_de_cena("res://tutoriais/tutorial_2.tscn")
			$"produção".visible = true
		
	if !Globals.tutoriais["tutorial01"] and !Globals.tutoriais["tutorial02"]:
		$porta_fechada.visible = true
	else:
		$porta_fechada.visible = false
