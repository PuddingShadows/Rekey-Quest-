extends Node

const GAME_VERSION = "1.7.0"
const SAVE_PATH := "user://save.json"


var tutoriais = {
	"tutorial0": false,
	"tutorial0_5": false,
	"tutorial01": true,
	"tutorial02": false,
	
	"tutorial_escada": true,
	"tutorial_poder1": true,
	"tutorial_poder2": false
}

var chaves = {
	"chave_mundo1": false,
	"chave_mundo1_hud": false,
	"chave_usada1": false
}

var portas = {
	"porta_mundo1": false,
	"open_play1": false,
}

var powers = {
	"war": false,
}

var doors_by_world := {}


var stars := 0

var editing = false
var in_menu = false
var god_mode = false
var console_open = false

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		return
		
	var data = {
		"tutoriais": tutoriais,
		"chaves": chaves,
		"portas": portas,
		"powers": powers,
		"stars": stars,
		"doors_by_world": doors_by_world,
		}
	
	
	file.store_string(JSON.stringify(data))
	file.close()

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		return false
					
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return false
		
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	
	
	if typeof(data) != TYPE_DICTIONARY:
		return false
		
	if data.has("tutoriais"):
		tutoriais = data.tutoriais
	if data.has("chaves"):
		chaves = data.chaves
	if data.has("portas"):
		portas = data.portas
	if data.has("powers"):
		powers = data.powers
	if data.has("stars"):
		stars = data.stars
	if data.has("doors_by_world"):
		doors_by_world = data.doors_by_world
		
	return true

func reset_save():
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
	
	tutoriais = {
		"tutorial0": false,
		"tutorial0_5": false,
		"tutorial01": true,
		"tutorial02": false,
		
		"tutorial_escada": true,
		"tutorial_poder1": true,
		"tutorial_poder2": false
	}
	
	chaves = {
		"chave_mundo1": false,
		"chave_mundo1_hud": false,
		"chave_usada1": false
	}
		
	portas = {
		"porta_mundo1": false,
		"open_play1": false,
	}
	
	powers = {
		"war": false,
	}
	
	doors_by_world = {}
	
	stars = 0
