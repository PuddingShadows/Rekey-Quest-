extends Button

@onready var SFX_select = $"../SFX_select"

func _on_pressed() -> void:
	get_tree().paused = false
	SFX_select.play()
	get_parent().visible = false
