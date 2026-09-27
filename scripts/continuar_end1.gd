extends Button

@onready var STX_select = $"../STX_select"

func _on_pressed() -> void:
	get_tree().paused = false
	STX_select.play()
	Transition.trocar_de_cena("res://lobbies/lobby_mundo_1.tscn")
