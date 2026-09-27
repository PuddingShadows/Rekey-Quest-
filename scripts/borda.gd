extends Node2D


func _on_teleport_to_right_1_body_entered(_body: Node2D) -> void:
	get_parent().get_node("player").position = Vector2(577, -15)
	get_parent().get_node("player").velocity.y = 0


func _on_teleport_to_right_2_body_entered(_body: Node2D) -> void:
	get_parent().get_node("player").position = Vector2(577, -15)
	get_parent().get_node("player").velocity.y = 0


func _on_teleport_to_left_1_body_entered(_body: Node2D) -> void:
	get_parent().get_node("player").position = Vector2(64, -15)
	get_parent().get_node("player").velocity.y = 0


func _on_teleport_to_left_2_body_entered(_body: Node2D) -> void:
	get_parent().get_node("player").position = Vector2(64, -15)
	get_parent().get_node("player").velocity.y = 0
