extends Area2D

@onready var anim = $"../AnimationPlayer"
@onready var porta = $"../porta-area5"
@onready var tile = $"../tilemap/ground2"
@onready var chão = $"../tilemap/ground3"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		anim.play("escurecer")
		tile.visible = false
		chão.visible = true
		porta.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		anim.play("clarear")
		tile.visible = true
		chão.visible = false
		porta.visible = false
		
