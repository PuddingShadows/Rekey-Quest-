extends Area2D

@onready var anim = $"../AnimationPlayer"
@onready var tile = $"../tilemap/ground2"
@onready var key = $"../key_area4"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var key_area = get_node_or_null("../key_area4")
		if key_area:
			key.visible = true
		tile.visible = false
		anim.play("escurecer1")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		var key_area = get_node_or_null("../key_area4")
		if key_area:
			key.visible = false
		tile.visible = true
		anim.play("clarear1")
