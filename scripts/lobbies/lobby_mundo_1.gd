extends Node2D

func _ready() -> void:
	if Globals.doors_by_world.has("LobbyMundo1"):
		Doors = Globals.doors_by_world["LobbyMundo1"].duplicate(true)
	else:
		Doors = {
			"Door1": false,
			"Stars_door1": 0,
			
			"Door2": false,
			"Stars_door2": 0,
			
			"Door3": false,
			"Stars_door3": 0,
			
			"Door4": false,
			"Stars_door4": 0,
			
			"Door5": false,
			"Stars_door5": 0
		}


var Doors = {}


func salvar_estrelas(nome_porta: String, estrelas: int):
	var world = Globals.doors_by_world.get("LobbyMundo1", {})
	
	var estrelas_anteriores: int = int(world.get(nome_porta, 0))
		
	if estrelas > estrelas_anteriores:
		world[nome_porta] = estrelas
		Globals.doors_by_world["LobbyMundo1"] = world
		
		var diferenca := estrelas - estrelas_anteriores
		Globals.stars += diferenca
		
		Globals.save_game()
