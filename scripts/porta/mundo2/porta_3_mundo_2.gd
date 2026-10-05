extends Area2D

@onready var label = $Label
@onready var SFX_select = $SFX_select

const STAR_TOTAL = 3

var player_in = false
var estrelas = 0

func atualizar_texto():
	if Globals.doors_by_world.has("LobbyMundo2"):
		if not Globals.doors_by_world["LobbyMundo2"].has("Stars_door8"):
			Globals.doors_by_world["LobbyMundo2"]["Stars_door8"] = 0
		estrelas = Globals.doors_by_world["LobbyMundo2"]["Stars_door8"]
		
	label.text = str(int(estrelas)) + "/" + str(STAR_TOTAL)
		
	label.remove_theme_color_override("font_color")
		
	if estrelas == STAR_TOTAL:
		label.add_theme_color_override("font_color", Color.GREEN)
	elif estrelas >= 1:
		label.add_theme_color_override("font_color", Color.WHITE)
	else:
		label.add_theme_color_override("font_color", Color.RED)


func anim_fade_in():
	var ui_select_button = get_parent().get_node("controls/ui_interect")
	var anim_btn = get_parent().get_node("controls/anim")
	
	if not anim_btn.is_playing() and ui_select_button.visible == false:
		anim_btn.play("fade_in")
		ui_select_button.visible = true
	else:
		await anim_btn.animation_finished
		ui_select_button.visible = true
		anim_btn.play("fade_in")
		
	if not $anim.is_playing():
		$anim.play("fade_in")
	else:
		await $anim.animation_finished
		$anim.play("fade_in")

func anim_fade_out():
	var ui_select_button = get_parent().get_node("controls/ui_interect")
	var anim_btn = get_parent().get_node("controls/anim")
			
	if not anim_btn.is_playing():
		anim_btn.play("fade_out")
	else:
		await anim_btn.animation_finished
		ui_select_button.visible = true
		anim_btn.play("fade_out")
	
	await anim_btn.animation_finished
	ui_select_button.visible = false
	player_in = false
	
	if not $anim.is_playing():
		$anim.play("fade_out")
	else:
		await $anim.animation_finished
		$anim.play("fade_out")

func _on_body_entered(_body: Node2D) -> void:
	
	player_in = true
	$Label.visible = true
	$star.visible = true
	
	anim_fade_in()

func _on_body_exited(_body: Node2D) -> void:
	anim_fade_out()
	
	player_in = false
	
	await $anim.animation_finished
	$Label.visible = false
	$star.visible = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in:
		SFX_select.play()
		Transition.trocar_de_cena("res://levels/level01.tscn")
	
	atualizar_texto()

func _ready():
	atualizar_texto()
