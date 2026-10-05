extends Node2D

func _ready() -> void:
	if Globals.doors_by_world.has("LobbyMundo2"):
		Doors = Globals.doors_by_world["LobbyMundo2"].duplicate(true)
	else:
		Doors = {
			"Door6": false,
			"Stars_door6": 0,
			
			"Door7": false,
			"Stars_door7": 0,
			
			"Door8": false,
			"Stars_door8": 0,
			
			"Door9": false,
			"Stars_door9": 0,
			
			"Door10": false,
			"Stars_door10": 0
		}


var Doors = {}


func salvar_estrelas(nome_porta: String, estrelas: int):
	var world = Globals.doors_by_world.get("LobbyMundo2", {})
	
	var estrelas_anteriores: int = int(world.get(nome_porta, 0))
		
	if estrelas > estrelas_anteriores:
		world[nome_porta] = estrelas
		Globals.doors_by_world["LobbyMundo2"] = world
		
		var diferenca := estrelas - estrelas_anteriores
		Globals.stars += diferenca
		
		Globals.save_game()
