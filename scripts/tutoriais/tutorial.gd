extends Node2D

@export var skin_number: int

func _ready() -> void:
	Globals.skin_player = skin_number
	$player.trocar_skin(Globals.skin_player)
	Globals.save_game()
