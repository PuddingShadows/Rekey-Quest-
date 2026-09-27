extends Control

var fade_execut = false

func _process(_delta: float) -> void:
	if !Globals.tutoriais["tutorial01"]:
		$Label.visible = true
		
		$W.visible = true
		$S.visible = true
		
		if !fade_execut:
			$anim.play("fade_in")
			print("ativou")
			fade_execut = true

func _ready() -> void:
	if !Globals.tutoriais["tutorial01"]:
		$anim.play("fade_in")
