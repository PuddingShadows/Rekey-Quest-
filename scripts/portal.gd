extends Area2D

@export var texture_portal = Texture2D
@export var teleport: Vector2

@onready var btn_e = $"../controls/ui_interect"
@onready var e_anim = $"../controls/anim"

var player_in = false
var player = null


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
		player = body
		player_in = true
		anim_fade_in()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_in = false
		anim_fade_out()
		
		await e_anim.animation_finished
		if not player_in:
			btn_e.visible = false


func _ready() -> void:
	$portal.texture = texture_portal

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in:
		player.tocar_animacao("morte")
		player.set_physics_process(false)
		await player.get_node("Anim").animation_finished
		player.tocar_animacao("renascer")
		player.position = teleport
		await player.get_node("Anim").animation_finished
		player.set_physics_process(true)
		player.velocity.y = 0
