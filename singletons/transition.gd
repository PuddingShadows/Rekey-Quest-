extends CanvasLayer

@onready var anim = $anim



func trocar_de_cena(destino):
	anim.play("fade_out")
	await anim.animation_finished
	anim.play("fade_in")
	get_tree().change_scene_to_file(destino)
