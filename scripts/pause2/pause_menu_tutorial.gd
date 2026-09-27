extends CanvasLayer

@onready var SFX_select = $SFX_select

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		visible = false
		
		
		# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta: float) -> void:
	pass


func pause_game():
	visible = true
	SFX_select.play()
	get_tree().paused = true

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_game()

func _on_resume_btn_pressed() -> void:
	get_tree().paused = false
	SFX_select.play()
	visible = false

func _on_options_btn_pressed() -> void:
	SFX_select.play()
	Globals.in_menu = true
	Transition.anim.play("fade_in")
	var opcoes = preload("res://scenes/opções.tscn").instantiate()
	add_child(opcoes)

func _on_quit_btn_pressed() -> void:
	get_tree().paused = false
	SFX_select.play()
	
	if Globals.tutoriais["tutorial0"] and Globals.tutoriais["tutorial0_5"]:
		Transition.trocar_de_cena("res://lobbies/lobby_principal.tscn")
	else:
		Transition.trocar_de_cena("res://scenes/menu.tscn")

func _on_restart_btn_pressed() -> void:
	get_tree().paused = false
	SFX_select.play()
	await get_tree().process_frame
	get_tree().reload_current_scene()
