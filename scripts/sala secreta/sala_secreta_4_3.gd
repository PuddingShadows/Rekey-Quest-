extends Area2D

@onready var anim = $"../AnimationPlayer"
@onready var morango = $"../strawberry-area4/strawberry"
@onready var barrier = $"../barrier2"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		barrier.z_index = 3
		var strawberry_area = get_node_or_null("../strawberry-area4")
		if strawberry_area:
			$"../strawberry-area4". visible = true
		anim.play("escurecer3")


func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		barrier.z_index = 0
		var strawberry_area = get_node_or_null("../strawberry-area4")
		if strawberry_area:
			$"../strawberry-area4". visible = false
		anim.play("clarear3")
