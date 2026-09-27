extends Area2D

@onready var SFX_collect = $SFX_collect

func _ready() -> void:
	if Globals.powers["war"]:
		queue_free()
		return
	desativar_area()

func _process(_delta: float) -> void:
	if !Globals.doors_by_world.has("LobbyMundo1"):
		Globals.doors_by_world["LobbyMundo1"] = {}
	if !Globals.doors_by_world["LobbyMundo1"].has("Door5"):
		Globals.doors_by_world["LobbyMundo1"]["Door5"] = false
	
	if Globals.powers["war"] == false and Globals.doors_by_world["LobbyMundo1"]["Door5"]:
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
	$powers.play("collect")
	SFX_collect.play()
	Globals.powers["war"] = true
	Globals.tutoriais["tutorial02"] = true
	Globals.tutoriais["tutorial_poder2"] = true
	Globals.save_game()


func _on_powers_animation_finished() -> void:
	queue_free()
