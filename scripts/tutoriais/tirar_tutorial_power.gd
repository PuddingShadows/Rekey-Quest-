extends Area2D

var fade_in_execut := false


func _ready():
	var tutorial = get_tree().get_root().get_node("lobby_mundo2/tutorial_power")
	var anim = get_tree().get_root().get_node("lobby_mundo2/tutorial_power/anim")
	
	tutorial.visible = false
	anim.stop()

func _process(_delta: float) -> void:
	if Globals.tutoriais["tutorial_poder2"]:
		var tutorial = get_tree().get_root().get_node("lobby_mundo2/tutorial_power")
		var fade_in = get_tree().get_root().get_node("lobby_mundo2/tutorial_power/anim")
		tutorial.visible = true
		if not fade_in_execut:
			fade_in.play("fade_in")
			fade_in_execut = true
	else:
		var tutorial = get_tree().get_root().get_node("lobby_mundo2/tutorial_power")
		var fade_out = get_tree().get_root().get_node("lobby_mundo2/tutorial_power/anim")
		fade_out.play("fade_out")
		await fade_out.animation_finished
		tutorial.visible = false


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Globals.tutoriais["tutorial_poder1"] = false
		if Globals.doors_by_world.has("LobbyMundo2"):
			if Globals.doors_by_world["LobbyMundo2"].has("Door10"):
				if Globals.doors_by_world["LobbyMundo2"]["Door10"]:
					Globals.tutoriais["tutorial_poder2"] = false
		Globals.save_game()
