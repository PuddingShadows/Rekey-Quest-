extends Area2D

@onready var SFX_select = $SFX_select

var player_in = false
var player_inside = false

func anim_fade_in():
	var ui_select_button = get_parent().get_node("controls/ui_interect")
	var anim_btn = get_parent().get_node("controls/anim")
			
	if not anim_btn.is_playing() and ui_select_button.visible == false:
		ui_select_button.visible = true
		anim_btn.play("fade_in")
	else:
		await anim_btn.animation_finished
		ui_select_button.visible = true
		anim_btn.play("fade_in")

func anim_fade_out():
	var ui_select_button = get_parent().get_node("controls/ui_interect")
	var anim_btn = get_parent().get_node("controls/anim")
			
	if not anim_btn.is_playing():
		anim_btn.play("fade_out")
	else:
		await anim_btn.animation_finished
		ui_select_button.visible = true
		anim_btn.play("fade_out")

func _on_body_entered(_body: Node2D) -> void:
	anim_fade_in()
	player_inside = true
	
	player_in = true
	$Label.visible = true
	
	if not $anim.is_playing():
		$anim.play("fade_in")

func _on_body_exited(_body: Node2D) -> void:
	anim_fade_out()
	player_inside = false
	
	var ui_select_button = get_parent().get_node("controls/ui_interect")
	var anim_btn = get_parent().get_node("controls/anim")
	
	await anim_btn.animation_finished
	if not player_inside:
		ui_select_button.visible = false
		player_in = false
	
	if not $anim.is_playing():
		$anim.play("fade_out")
	
	await $anim.animation_finished
	$Label.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in:
		SFX_select.play()
		Transition.trocar_de_cena("res://lobbies/lobby_principal.tscn")
