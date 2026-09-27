extends Area2D

signal key_collected

@onready var SFX_collect = $SFX_collect

var collected_body: Node2D = null
var amplitude := -4.0
var speed := 2.5
var t := 1.0
var base_y := 2.0


func _ready() -> void:
	base_y = position.y

func _process(delta: float) -> void:
	t += delta * speed
	position.y = base_y + sin(t) * amplitude


func _on_body_entered(body: Node2D) -> void:
	collected_body = body
	$key.play("collect")
	SFX_collect.play()
	


func _on_key_animation_finished() -> void:
	if collected_body and collected_body.name == "player":
		collected_body.red_key = true
	key_collected.emit()
	queue_free()
