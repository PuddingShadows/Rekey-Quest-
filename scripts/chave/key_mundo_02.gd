extends Area2D

@onready var SFX_collect = $SFX_collect

func _ready() -> void:
	if Globals.chaves.get("chave_usada2", false):
		queue_free()
		return
	desativar_area()

func _process(_delta: float) -> void:
	if Globals.tutoriais["tutorial02"] == false:
		ativar_area()


func desativar_area():
	monitoring = false
	monitorable = false
	visible = false

func ativar_area():
	monitoring = true
	monitorable = true
	visible = true


func _on_body_entered(_body: Node2D) -> void:
	$key.play("collect")
	SFX_collect.play()
	Globals.chaves["chave_mundo2"] = true
	Globals.chaves["chave_mundo2_hud"] = true
	Globals.save_game()

func _on_key_animation_finished() -> void:
	queue_free()
