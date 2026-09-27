extends Area2D

@onready var SFX_select = $SFX_select

@onready var btn_e = $"../controls/ui_interect"
@onready var e_anim = $"../controls/anim"

@export var tutorial : Control = null
@export var anim : AnimationPlayer = null

var player_inside := false
var player_in = false


func anim_fade_in():
	if not e_anim.is_playing() and btn_e.visible == false:
		btn_e.visible = true
		e_anim.play("fade_in")
	else:
		await e_anim.animation_finished
		btn_e.visible = true
		e_anim.play("fade_in")

func anim_fade_out():
	if not e_anim.is_playing():
		e_anim.play("fade_out")
	else:
		await e_anim.animation_finished
		btn_e.visible = true
		e_anim.play("fade_out")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_in = true
		player_inside = true
		anim_fade_in()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_inside = false
		player_in =  false
		anim_fade_out()
		
		await e_anim.animation_finished
		if not player_inside:
			btn_e.visible = false
			anim.play("fade_out")
			await anim.animation_finished
			tutorial.visible = false
			Globals.tutoriais["tutorial_escada"] = false


func _process(_delta):
	if Input.is_action_just_pressed("interact") and player_in and Globals.tutoriais["tutorial_escada"] == false:
		tutorial.visible = true
		Globals.tutoriais["tutorial_escada"] = true
		SFX_select.play()
		anim.play("fade_in")
	elif Input.is_action_just_pressed("interact") and player_in:
		SFX_select.play()
