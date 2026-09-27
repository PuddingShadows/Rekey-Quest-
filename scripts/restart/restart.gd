extends Button

@onready var SFX_select = $"../SFX_select"

func _on_pressed() -> void:
	get_tree().paused = false
	SFX_select.play()
	await get_tree().process_frame
	get_tree().reload_current_scene()
