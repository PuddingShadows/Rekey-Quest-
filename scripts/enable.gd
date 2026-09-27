extends TouchScreenButton

var touchs = 0

func _process(_delta: float) -> void:
	if touchs == 3:
		get_parent().get_node("console_btn").visible = true
	elif touchs == 6:
		get_parent().get_node("console_btn").visible = false
		touchs = 0

func _on_pressed() -> void:
	if touchs < 6:
		touchs += 1
