extends Control

@export var Player_ref : Node2D = null

@export var anim : AnimationPlayer = null


var fade_execut = false
var fade_execut2 = false

var chave = false
var placa = false


func _process(_delta: float) -> void:
	if Player_ref.red_key:
		chave = true
	
	if !fade_execut and chave:
		anim.play("fade_out")
		fade_execut = true
		await get_tree().create_timer(0.6).timeout
		anim.play("fade_in")
		placa = true
		$tutorial_placa.visible = true

func _ready() -> void:
	anim.play("fade_in")

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		$tutorial_chave.visible = false
		$tutorial_placa.visible = false
