extends Area2D

@export var tutorial : Control = null

func _on_body_entered(_body: Node2D) -> void:
	get_parent().get_node("player").position = Vector2(73, -22)
	get_parent().get_node("player").velocity.y = 0
	
	tutorial.atalho = false
