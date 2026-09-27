extends Button

@onready var STX_select = $"../STX_select"

func _on_pressed() -> void:
	get_tree().paused = false
	STX_select.play()
	await get_tree().process_frame
	get_tree().reload_current_scene()
