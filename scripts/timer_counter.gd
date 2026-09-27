extends Label

var counting := false

func start_time():
	counting = true

func stop_timer():
	counting = false

func _process(delta):
	if counting:
		get_parent().get_parent().time += delta
		var seconds = int(get_parent().get_parent().time) % 60
		var minutes = int(get_parent().get_parent().time) / 60
		text = "%02d:%02d" % [minutes, seconds]
