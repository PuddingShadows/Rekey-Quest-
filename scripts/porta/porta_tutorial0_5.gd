extends Area2D

@onready var ui_select_button = controls.get_node("ui_interect")
@onready var anim_btn = controls.get_node("anim")

@onready var SFX_open = $SFX_open
@onready var SFX_select = $SFX_select

@export var controls : CanvasLayer = null

var has_fade = false
var player_inside = false
var open_play = false

func anim_fade_in():
	if not anim_btn.is_playing() and ui_select_button.visible == false:
		ui_select_button.visible = true
		anim_btn.play("fade_in")
	else:
		await anim_btn.animation_finished
		ui_select_button.visible = true
		anim_btn.play("fade_in")

func anim_fade_out():
	if not anim_btn.is_playing():
		anim_btn.play("fade_out")
	else:
		await anim_btn.animation_finished
		anim_btn.play("fade_out")
	await anim_btn.animation_finished
	if not player_inside:
		ui_select_button.visible = false

func _on_body_entered(body: Node2D) -> void:
	player_inside = true
	
	if body.red_key:
		if !open_play:
			SFX_open.play()
			open_play = true
		anim_fade_in()
		$porta_aberta.visible = true
		if not has_fade:
			$fade_porta.play("fade_in")
			has_fade = true
			await $fade_porta.animation_finished
			$porta.visible = false
		
	else:
		$porta.visible = true
		$porta_aberta.visible = false

func _on_body_exited(_body: Node2D) -> void:
	anim_fade_out()
	player_inside = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_inside:
		SFX_select.play()
		Globals.tutoriais["tutorial0_5"] = true
		Transition.trocar_de_cena("res://lobbies/lobby_principal.tscn")
		Globals.save_game()
