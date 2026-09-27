extends Area2D

var entered = false

var flag = false

var fade_execut1 = false
var fade_execut2 = false

@export var tutorial : Control = null
@export var anim : AnimationPlayer = null

@export var Label2 : Label = null
@export var space : Sprite2D = null


func _process(_delta: float) -> void:
	if !entered:
		return
	
	if !fade_execut1:
		Label2.visible = true
		space.visible = true
		fade_execut1 = true
		
	if tutorial.jump and !fade_execut2:
		anim.play("fade_out")
		fade_execut2 = true


func _on_body_entered(_body: Node2D) -> void:
	if flag:
		return
	
	entered = true
	flag = true
	anim.play("fade_in")


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out" and tutorial.jump:
		Label2.visible = false
		space.visible = false
