extends Control

@export var anim : AnimationPlayer = null


var fade_execut = false
var fade_execut2 = false

var passagem = false
var atalho = false

func _process(_delta: float) -> void:
	if !fade_execut and !passagem:
		anim.play("fade_in")
		$tutorial_passagem.visible = true
		fade_execut = true
	
	if !fade_execut2 and passagem:
		anim.play("fade_out_fast")
		fade_execut2 = true

func _ready() -> void:
	anim.play("fade_in")


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out" or anim_name == "fade_out_fast":
		$tutorial_passagem.visible = false
		$tutorial_atalho.visible = false
