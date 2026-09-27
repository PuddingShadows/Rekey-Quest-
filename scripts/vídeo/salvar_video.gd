extends Button


func _on_pressed() -> void:
	var op = get_parent().get_parent().get_parent()
	op.salvar_tudo()
	
	ConfigGlobal.salvar_no_disco()
