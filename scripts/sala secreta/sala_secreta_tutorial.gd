extends Area2D

@export var anim : AnimationPlayer = null
@export var chave : Area2D = null
@export var platform : StaticBody2D = null

@export var tutorial : Control = null


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		tutorial.passagem = true
		
		anim.play("escurecer")
		platform.visible = true
		
		var key_area = get_node_or_null("../key_tutorial1")
		if key_area:
			chave.get_node("key").visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		anim.play("clarear")
		platform.visible = false
		
		var key_area = get_node_or_null("../key_tutorial1")
		if key_area:
			chave.get_node("key").visible = false
