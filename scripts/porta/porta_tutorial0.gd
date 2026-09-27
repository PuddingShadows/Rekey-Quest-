extends Area2D

@onready var ui_select_button = controls.get_node("ui_interect")
@onready var anim_btn = controls.get_node("anim")

@onready var SFX_open = $SFX_open
@onready var SFX_select = $SFX_select

@export var controls : CanvasLayer = null
@export var anim_tutorial : AnimationPlayer = null
@export var Label3 : Label = null

var fade_execut1 = false
var fade_execut2 = false

var player_inside = false

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

func _on_body_entered(_body: Node2D) -> void:
	player_inside = true
	fade_execut2 = false
	anim_fade_in()
	
	if !fade_execut1:
		Label3.visible = true
		anim_tutorial.play("fade_in_fast")
		fade_execut1 = true

func _on_body_exited(_body: Node2D) -> void:
	player_inside = false
	fade_execut1 = false
	anim_fade_out()
	
	if !fade_execut2:
		anim_tutorial.play("fade_out_fast")
		

func _process(_delta: float) -> void:
	$porta_aberta.visible = true
	$porta.visible = false
	
	if Input.is_action_just_pressed("interact"):
		SFX_select.play()
		Globals.tutoriais["tutorial0"] = true
		Transition.trocar_de_cena("res://tutoriais/tutorial_0_5.tscn")
		Globals.save_game()


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out_fast":
		Label3.visible = false
		fade_execut2 = true
