extends Area2D

@onready var anim = $"../AnimationPlayer"
@onready var tile = $"../tilemap/ground3"
@onready var barrier = $"../barrier1"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		barrier.z_index = 3
		tile.visible = false
		anim.play("escurecer2")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		barrier.z_index = 0
		tile.visible = true
		anim.play("clarear2")
