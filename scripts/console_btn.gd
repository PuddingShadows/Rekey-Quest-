extends TouchScreenButton


func _on_pressed() -> void:
	Console.toggle_console()
	if Globals.console_open:
		Globals.console_open = false
	else:
		Globals.console_open = true
	#print("console")
