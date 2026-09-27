extends Area2D

@onready var anim = $"../AnimationPlayer"
@onready var tile = $"../tilemap/ground2"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		anim.play("escurecer_1")
		tile.z_index = 1

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		anim.play("clarear_1")
		tile.z_index = 2
