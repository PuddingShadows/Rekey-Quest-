extends AnimatedSprite2D


func _ready():
	self.play("jump_dust")

func _on_animation_finished() -> void:
	queue_free()
