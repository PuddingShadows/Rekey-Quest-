extends Area2D

@onready var SFX_select = $SFX_select

@onready var btn_e = $"../controls/ui_interect"
@onready var e_anim = $"../controls/anim"
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
		var tutorial = get_tree().get_root().get_node("lobby_mundo1/como_funciona")
		var fade_out = get_tree().get_root().get_node("lobby_mundo1/como_funciona/anim")
		fade_out.play("fade_out")
		await fade_out.animation_finished
		tutorial.visible = false
		Globals.tutoriais["tutorial_poder1"] = false
		Globals.tutoriais["tutorial_poder2"] = false


func _process(_delta):
	if Input.is_action_just_pressed("interact") and player_in and Globals.tutoriais["tutorial_poder1"] == false or Input.is_action_just_pressed("ui_select") and player_in and Globals.tutoriais["tutorial_poder2"]:
		SFX_select.play()
		var tutorial = get_tree().get_root().get_node("lobby_mundo1/como_funciona")
		var fade_in = get_tree().get_root().get_node("lobby_mundo1/como_funciona/anim")
		tutorial.visible = true
		Globals.tutoriais["tutorial_poder1"] = true
		Globals.tutoriais["tutorial_poder2"] = true
		fade_in.play("fade_in")
	elif Input.is_action_just_pressed("interact") and player_in:
		SFX_select.play()
