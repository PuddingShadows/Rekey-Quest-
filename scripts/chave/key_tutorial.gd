extends Area2D

@onready var SFX_collect = $SFX_collect

@export var hud : CanvasLayer = null

var collected_body: Node2D = null

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	collected_body = body
	$key.play("collect")
	SFX_collect.play()

func _on_key_animation_finished() -> void:
	if collected_body and collected_body.name == "player":
		collected_body.red_key = true
		hud.atualizar_icones_chaves(collected_body.red_key)
		queue_free()
