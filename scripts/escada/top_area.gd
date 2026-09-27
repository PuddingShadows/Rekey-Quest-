extends Area2D

@onready var btn_e = $"../../controls/ui_down"
@onready var e_anim = $"../../controls/anim"
@export var target_position = Vector2(328, 238)
var player_inside := false

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

func _on_body_entered(body):
	if body.name == "player":
		player_inside = true
		anim_fade_in()
		
		
		body.can_use_ladder1 = true
		body.ladder_target = target_position

func _on_body_exited(body):
	if body.name == "player":
		player_inside = false
		anim_fade_out()
		
		await e_anim.animation_finished
		if not player_inside:
			btn_e.visible = false
			body.can_use_ladder1 = false
