extends Area2D

@onready var label = $Label
@onready var SFX_select = $SFX_select

const STAR_TOTAL = 3

var player_in = false
var estrelas = 0

func atualizar_texto():
	if Globals.doors_by_world.has("LobbyMundo1"):
		if not Globals.doors_by_world["LobbyMundo1"].has("Stars_door4"):
			Globals.doors_by_world["LobbyMundo1"]["Stars_door4"] = 0
		estrelas = Globals.doors_by_world["LobbyMundo1"]["Stars_door4"]
			
		label.text = str(int(estrelas)) + "/" + str(STAR_TOTAL)
		
		label.remove_theme_color_override("font_color")
		
		if estrelas == STAR_TOTAL:
			label.add_theme_color_override("font_color", Color.GREEN)
		elif estrelas >= 1:
			label.add_theme_color_override("font_color", Color.WHITE)
		else:
			label.add_theme_color_override("font_color", Color.RED)


func anim_fade_in():
	var anim_btn = get_tree().root.get_node("lobby_mundo1/controls/anim")
	var ui_select_button = get_tree().root.get_node("lobby_mundo1/controls/ui_interect")
	
	if not anim_btn.is_playing() and ui_select_button.visible == false:
		ui_select_button.visible = true
		anim_btn.play("fade_in")
	else:
		await anim_btn.animation_finished
		ui_select_button.visible = true
		anim_btn.play("fade_in")

func anim_fade_out():
	var anim_btn = get_tree().root.get_node("lobby_mundo1/controls/anim")
	var ui_select_button = get_tree().root.get_node("lobby_mundo1/controls/ui_interect")
	
	if not anim_btn.is_playing():
		anim_btn.play("fade_out")
	else:
		await anim_btn.animation_finished
		ui_select_button.visible = true
		anim_btn.play("fade_out")
	
	await anim_btn.animation_finished
	ui_select_button.visible = false
	player_in = false

func _on_body_entered(_body: Node2D) -> void:
	var estrelas = Globals.stars
	
	if !Globals.doors_by_world.has("LobbyMundo1"):
		Globals.doors_by_world["LobbyMundo1"] = {}
		if !Globals.doors_by_world["LobbyMundo1"].has("Door3"):
			Globals.doors_by_world["LobbyMundo1"]["Door3"] = false
	
	if estrelas >= 7 and Globals.doors_by_world["LobbyMundo1"]["Door3"]:
		anim_fade_in()
		
		player_in = true
		$Label.visible = true
		$star.visible = true
		
		if not $anim.is_playing():
			$anim.play("fade_in")
		
	else:
		$star.visible = true
		$estrelas_necessarias.visible = true
		
		if not $anim.is_playing():
			$anim.play("fade_in")

func _on_body_exited(_body: Node2D) -> void:
	anim_fade_out()
	
	player_in = false
	
	if not $anim.is_playing():
		$anim.play("fade_out")
	
	await $anim.animation_finished
	$Label.visible = false
	$star.visible = false
	$estrelas_necessarias.visible = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in:
		Transition.trocar_de_cena("res://levels/level04.tscn")
		SFX_select.play()
		
	if !Globals.doors_by_world.has("LobbyMundo1"):
		Globals.doors_by_world["LobbyMundo1"] = {}
		
	if !Globals.doors_by_world["LobbyMundo1"].has("Door3"):
		Globals.doors_by_world["LobbyMundo1"]["Door3"] = false
	
	if Globals.doors_by_world.has("LobbyMundo1"):
		var estrelas = Globals.stars
		var porta3 = Globals.doors_by_world["LobbyMundo1"]["Door3"]
		if estrelas >= 7 and porta3:
			$porta_aberta.visible = true
			$porta_fechada.visible = false
		else:
			$porta_aberta.visible = false
			$porta_fechada.visible = true
		
	atualizar_texto()
