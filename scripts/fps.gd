extends CanvasLayer


func _process(_delta: float) -> void:
	$fps.text = "FPS:" + str(int(Engine.get_frames_per_second()))
