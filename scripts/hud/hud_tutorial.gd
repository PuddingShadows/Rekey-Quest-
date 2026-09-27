extends CanvasLayer



func _ready():
	pass


func _process(_delta: float) -> void:
	pass

func atualizar_icones_chaves(red_key: bool):
	if red_key:
		$chave_escondida.visible = false
		$chave_encontrada.visible = true
	else:
		$chave_escondida.visible = true
		$chave_encontrada.visible = false
