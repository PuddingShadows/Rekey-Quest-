extends Node

func _process(_delta: float) -> void:
	if Globals.god_mode:
		Globals.portas["porta_mundo1"] = true
		Globals.stars = 99
		if !Globals.doors_by_world.has("LobbyMundo1"):
			Globals.doors_by_world["LobbyMundo1"] = {}
			Globals.doors_by_world["LobbyMundo1"]["Door1"] = true
			Globals.doors_by_world["LobbyMundo1"]["Stars_door1"] = 3
			
			Globals.doors_by_world["LobbyMundo1"]["Door2"] = true
			Globals.doors_by_world["LobbyMundo1"]["Stars_door2"] = 3
			
			Globals.doors_by_world["LobbyMundo1"]["Door3"] = true
			Globals.doors_by_world["LobbyMundo1"]["Stars_door3"] = 3
			
			Globals.doors_by_world["LobbyMundo1"]["Door4"] = true
			Globals.doors_by_world["LobbyMundo1"]["Stars_door4"] = 3
			
			Globals.doors_by_world["LobbyMundo1"]["Door5"] = true
			Globals.doors_by_world["LobbyMundo1"]["Stars_door5"] = 3
		else:
			Globals.doors_by_world["LobbyMundo1"]["Door1"] = true
			Globals.doors_by_world["LobbyMundo1"]["Stars_door1"] = 3
			
			Globals.doors_by_world["LobbyMundo1"]["Door2"] = true
			Globals.doors_by_world["LobbyMundo1"]["Stars_door2"] = 3
			
			Globals.doors_by_world["LobbyMundo1"]["Door3"] = true
			Globals.doors_by_world["LobbyMundo1"]["Stars_door3"] = 3
			
			Globals.doors_by_world["LobbyMundo1"]["Door4"] = true
			Globals.doors_by_world["LobbyMundo1"]["Stars_door4"] = 3
			
			Globals.doors_by_world["LobbyMundo1"]["Door5"] = true
			Globals.doors_by_world["LobbyMundo1"]["Stars_door5"] = 3

func _ready() -> void:
	Console.add_command("fps_show", fps_show, 0, 0, "fps aparece")
	Console.add_command("fps_hide", fps_hide, 0, 0, "esconde fps")
	Console.add_command("give_stars", give_stars, ["amount"], 0, "pega estrelas")
	Console.add_command("drop_stars", drop_stars, ["amount"], 0, "larga estrelas")
	Console.add_command("tt", tutorial, ["tutorial", "Bool"], 2, "define se um tutorial é concluído ou não")
	Console.add_command("drop_key1", drop_key1, 0, 0, "larga a chave do mundo 1")
	Console.add_command("give_key1", give_key1, 0, 0, "pega a chave do mundo 1")
	Console.add_command("w", mundo, ["world", "Bool"], 2, "determina se um mundo é aberto ou não")
	Console.add_command("dw", portamundo, ["door", "world", "Bool"], 3, "determina se uma porta de um mundo é concluída ou não")
	Console.add_command("set_stars", set_stars, ["world", "door", "amount"], 3, "define a estrelas de uma porta de um mundo")
	Console.add_command("fullscreen", fullscreen, ["Bool"], 1, "ativa/desativa tela cheia")
	Console.add_command("v-sync", vsync, ["Bool"], 1, "ativa/desativa V-SYNC")
	Console.add_command("screen_mode", screen_mode, ["modo"], 1, "muda o modo de tela")
	Console.add_command("lighting", lighting, ["value"], 1, "altera a iluminação")
	Console.add_command("geral_vol", geral_volume, ["value"], 1, "altera o volume geral")
	Console.add_command("sfx", sfx, ["value"], 1, "altera o volume dos efeitos sonoros")
	Console.add_command("velocity", velocity, ["value"], 1, "altera a velocidade do jogo")
	Console.add_command("god_pudding", god, ["Bool"], 0, "ativa o modo god")


func str_to_bool(value: String):
	var v = value.strip_edges().to_lower()
		
	if v == "true":
		return true
	elif v == "false":
		return false
	else:
		return null

func percent_to_db(num: float) -> float:
	if num <= 0:
		return -80
	return linear_to_db(num / 100.0)


func god(Bool):
	var B = str_to_bool(Bool)
	
	if B:
		Globals.god_mode = true
		Console.print_info("modo god ativado (em produção ainda)")
	elif B == false:
		Globals.god_mode = false
		Console.print_info("modo god desativado")
	else:
		Console.print_error("valor incorreto")

func velocity(value):
	var scale = float(value)
	scale = clamp(scale, 0.0, 100.0) # evita insanidade
	Engine.time_scale = scale
	
	Console.print_info("Velocidade do jogo alterada para: " + str(scale) + "x")

func sfx(value):
	var num = float(value)
	num = clamp(num, 0, 100)
	
	var bus_index = AudioServer.get_bus_index("sfx")
	AudioServer.set_bus_volume_db(bus_index, percent_to_db(num))
	
	Console.print_info("volume dos efeitos sonoros " + str(num) + "%")

func geral_volume(value):
	var num = float(value)
	num = clamp(num, 0, 100)
	
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, percent_to_db(num))
	
	Console.print_info("volume geral em " + str(num) + "%")

func lighting(value):
	var num = float(value)
	num = clamp(num, 0, 100)
	
	var t = pow(num / 100.0, 1.5)
	var convertido = lerp(0.6, 1.4, t)
	EnvironmentManager.get_node("WorldEnvironment").color = Color(convertido, convertido, convertido, 1)
	Console.print_info("iluminação em " + str(num) + "%")

func screen_mode(modo):
	if modo == "viewport":
		get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
		Console.print_info("modo pixel ativado")
	elif modo == "canvas_item":
		get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
		Console.print_info("modo normal ativado")
	else:
		Console.print_error("modo inexistente")

func vsync(Bool):
	var B = str_to_bool(Bool)
	
	if B:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		Console.print_info("V-sync ativada")
		#print("VSync Ativado")
	elif B == false:
		Console.print_info("V-sync desativada")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_MAILBOX)
	else:
		Console.print_error("valor incorreto")

func fullscreen(Bool):
	var B = str_to_bool(Bool)
	
	if B:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Console.print_info("tela cheia ativada")
	elif B == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Console.print_info("tela cheia desativada")
	
	else:
		Console.print_error("valor incorreto")

func set_stars(world, door, amount):
	var world_key = "LobbyMundo" + world
	var door_key = "Stars_door" + door
	var value = amount.to_int()
	
	if !Globals.doors_by_world.has(world_key):  
		Globals.doors_by_world[world_key] = {}  
	
	if !Globals.doors_by_world[world_key].has(door_key):  
		Globals.doors_by_world[world_key][door_key] = 0  
	
	Globals.doors_by_world[world_key][door_key] = value  
	Console.print_info("Estrelas definidas para " + world_key + " " + door_key + "")

func portamundo(door, world, Bool):
	var world_key = "LobbyMundo" + world
	var door_key = "Door" + door
	var B = str_to_bool(Bool)
	
	if !Globals.doors_by_world.has(world_key):  
		Globals.doors_by_world[world_key] = {}  
		
	if !Globals.doors_by_world[world_key].has(door_key):  
		Globals.doors_by_world[world_key][door_key] = false
	
	
	if int(world) > 5:
		Console.print_error("mundo não existe")
		return
	if int(door) > 5:
		Console.print_error("porta não existe")
		return
	
	
	if B:
		Globals.doors_by_world[world_key][door_key] = true
		Console.print_info("porta: " + door + " do mundo: " + world + " concluída!")
	elif B == false:
		Globals.doors_by_world[world_key][door_key] = false
		Console.print_info("porta: " + door + " do mundo: " + world + " agora não está concluída")
	else:
		Console.print_error("valor incorreto")

func give_stars(amount):
	var value = amount.to_int()
	Globals.stars += value
	Console.print_info("pegou " + str((value)) + " estrelas")

func drop_stars(amount):
	var value = amount.to_int()
	Globals.stars -= value
	Console.print_info("- " + str((value)) + " estrelas")

func give_key1():
	Globals.chaves["chave_mundo1"] = true
	Globals.chaves["chave_mundo1_hud"] = true
	Console.print_info("chave do mundo 1 pega")

func drop_key1():
	Globals.chaves["chave_mundo1"] = false
	Globals.chaves["chave_mundo1_hud"] = false
	Console.print_info("chave do mundo 1 largada")

func mundo(world, Bool):
	var world_key = "porta_mundo" + world
	var B = str_to_bool(Bool)
	
	if int(world) > 1:
		Console.print_error("mundo não existe")
		return
	
	if B:
		Globals.portas[world_key] = true
		Console.print_info(world_key + " aberta")
	elif B == false:
		Globals.portas[world_key] = false
		Console.print_info(world_key + " fechada")
	else:
		Console.print_error("valor incorreto")

func fps_show():
	ConsoleEnable.get_node("fps").show()
	Console.print_info("fps está a mostra")

func fps_hide():
	ConsoleEnable.get_node("fps").hide()
	Console.print_info("fps foi escondido")

func tutorial(tutorial, Bool):
	var tutorial_key = "tutorial" + tutorial
	var B = str_to_bool(Bool)
	
	if int(tutorial) > 4:
		Console.print_error("tutorial não existe")
		return
	
	if B:
		Globals.tutoriais[tutorial_key] = true
		Console.print_info(tutorial_key + " concluído")
	elif B == false:
		Globals.tutoriais[tutorial_key] = false
		Console.print_info(tutorial_key + " deixou de ser concluído")
	else:
		Console.print_error("valor incorreto")
