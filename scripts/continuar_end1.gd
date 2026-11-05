extends Button

@onready var STX_select = $"../STX_select"

func _on_pressed() -> void:
	get_tree().paused = false
	STX_select.play()
	
	var porta = get_parent().get_parent().get_parent()
	Transition.trocar_de_cena(porta.cena_lobby)
