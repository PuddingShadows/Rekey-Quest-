extends Area2D

@onready var SFX_collect = $SFX_collect

func _ready() -> void:
	if Globals.powers["conquest"]:
		queue_free()
		return
	desativar_area()

func _process(_delta: float) -> void:
	if !Globals.doors_by_world.has("LobbyMundo2"):
		Globals.doors_by_world["LobbyMundo2"] = {}
	if !Globals.doors_by_world["LobbyMundo2"].has("Door10"):
		Globals.doors_by_world["LobbyMundo2"]["Door10"] = false
	
	if Globals.powers["conquest"] == false and Globals.doors_by_world["LobbyMundo2"]["Door10"]:
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
	Globals.powers["conquest"] = true
	Globals.tutoriais["tutorial03"] = true
	Globals.tutoriais["tutorial_poder2"] = true
	Globals.save_game()


func _on_powers_animation_finished() -> void:
	queue_free()
