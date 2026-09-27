extends ScrollContainer


func _ready() -> void:
	var v_bar = get_v_scroll_bar()
	v_bar.custom_minimum_size.x = 15
