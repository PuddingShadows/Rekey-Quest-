extends Area2D

var collected_body: Node2D = null

func _on_body_entered(body: Node2D) -> void:
	collected_body = body
	$strawberry.play("collect")
	print("teste")



func _on_strawberry_animation_finished() -> void:
	if collected_body and collected_body.name == "player":
		collected_body.strawberry = true
		var hud = get_tree().get_root().get_node("level01/HUD")
		hud.atualizar_icones_morango(collected_body.strawberry)
		queue_free()
