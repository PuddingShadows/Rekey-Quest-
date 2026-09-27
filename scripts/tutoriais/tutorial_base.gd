extends Control

@export var Player_ref : Node2D = null

@export var anim : AnimationPlayer = null


var fade_execut = false
var fade_execut2 = false

var move = false
var jump = false

var player_position = Vector2.ZERO


func _process(_delta: float) -> void:
	if Player_ref.global_position != player_position:
		move = true
	
	if Player_ref.global_position.y != player_position.y:
		jump = true
	
	if !move:
		$Label.visible = true
		
		$A.visible = true
		$D.visible = true
	
	
	
	if !fade_execut:
		if !move:
			anim.play("fade_in")
			fade_execut = true
	
	if !fade_execut2:
		if move:
			anim.play("fade_out")
			fade_execut2 = true

func _ready() -> void:
	if !move:
		anim.play("fade_in")
		player_position = Player_ref.global_position


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		$Label.visible = false
		
		$A.visible = false
		$D.visible = false
