extends Button


func _on_pressed() -> void:
	var pause_menu = get_parent().get_parent().get_node("pause_menu")
	pause_menu.pause_game()
	
	
