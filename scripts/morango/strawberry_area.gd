extends Area2D

signal strawberry_collected

@onready var SFX_collect = $SFX_collect

var collected_body: Node2D = null

func _on_body_entered(body: Node2D) -> void:
	collected_body = body
	$strawberry.play("collect")
	SFX_collect.play()


func _on_strawberry_animation_finished() -> void:
	if collected_body and collected_body.name == "player":
		get_parent().strawberry = true
		strawberry_collected.emit()
		queue_free()
