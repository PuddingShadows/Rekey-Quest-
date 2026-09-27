extends Control

var fade_execut = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Globals.doors_by_world.has("LobbyMundo1"):
		if Globals.doors_by_world["LobbyMundo1"].has("Door5"):
			if Globals.doors_by_world["LobbyMundo1"]["Door5"]:
				$Label.visible = false
				$Label2.visible = true
	if Globals.tutoriais["tutorial_poder2"] and !fade_execut:
		$anim.play("fade_in")
		fade_execut = true
