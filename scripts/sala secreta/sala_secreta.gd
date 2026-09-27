extends Area2D

@onready var anim = $"../AnimationPlayer"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		anim.play("Escurecer")
		var strawberry_area = get_node_or_null("../strawberry-area")
		if strawberry_area:
			$"../strawberry-area". visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		anim.play("Clarear")
		var strawberry_area = get_node_or_null("../strawberry-area")
		if strawberry_area:
			$"../strawberry-area".visible = false
