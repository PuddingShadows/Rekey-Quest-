extends Control

@onready var SFX_select = $SFX_select

func _ready() -> void:
	Globals.load_game()
	#apaga config.cfg:
	var dir = DirAccess.open("user://")
	var apagar = false
	if dir.file_exists("config.cfg") and apagar:
		dir.remove("config.cfg")
		print("config.cfg apagado!")


func _on_play_pressed() -> void:
	SFX_select.play()
	if !Globals.tutoriais["tutorial0"]:
		Transition.trocar_de_cena("res://tutoriais/tutorial_0.tscn")
	elif !Globals.tutoriais["tutorial0_5"]:
		Transition.trocar_de_cena("res://tutoriais/tutorial_0_5.tscn")
	else:
		Transition.trocar_de_cena("res://lobbies/lobby_principal.tscn")

func _on_quit_pressed() -> void:
	Transition.anim.play("fade_out")
	SFX_select.play()
	await Transition.anim.animation_finished
	get_tree().quit()

func _on_options_pressed() -> void:
	SFX_select.play()
	Transition.trocar_de_cena("res://scenes/opções.tscn")
