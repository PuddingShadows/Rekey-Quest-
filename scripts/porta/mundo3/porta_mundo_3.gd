extends Area2D


func _on_body_entered(_body: Node2D) -> void:
	$trancado.visible = true
	
	if not $anim.is_playing():
		$anim.play("fade_in")


func _on_body_exited(_body: Node2D) -> void:
	if not $anim.is_playing():
		$anim.play("fade_out")
	
	await $anim.animation_finished
	$trancado.visible = false
