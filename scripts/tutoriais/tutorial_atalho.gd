extends Area2D

var entered = false

var flag = false

var fade_execut1 = false
var fade_execut2 = false

@export var tutorial : Control = null
@export var anim : AnimationPlayer = null

@export var atalho : Label = null

func _process(_delta: float) -> void:
	if !entered:
		return
	
	if !fade_execut1:
		atalho.visible = true
		fade_execut1 = true
		
	if !tutorial.atalho and !fade_execut2:
		anim.play("fade_out")
		fade_execut2 = true


func _on_body_entered(_body: Node2D) -> void:
	if flag:
		return
	
	entered = true
	flag = true
	tutorial.atalho = true
	anim.play("fade_in")
