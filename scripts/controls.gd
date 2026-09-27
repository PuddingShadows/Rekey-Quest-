extends CanvasLayer

var dragging_node : TouchScreenButton = null
var selected_button : TouchScreenButton = null
var original_scale : Vector2

var default_positions := {}
var original_scales := {}
var original_opacity := {}

@onready var reset_timer = $resetTimer

func _ready() -> void:
	#Globals.editing = true
	visible = true
	
	
	for child in get_children():
		if child is TouchScreenButton:
			default_positions[child.name] = child.position
			
			original_scales[child.name] = child.scale
			
			original_opacity[child.name] = 1.0
	
	if Globals.editing:
		$anim.play("default")
		$ui_interect.visible = true
		$ui_down.visible = true
		$ui_up.visible = true
		$background.visible = true
		$texto.visible = true
		$sair.visible = true
	else:
		$background.visible = false
		$ui_interect.visible = false
		$ui_down.visible = false
		$ui_up.visible = false
		$texto.visible = false
		$sair.visible = false
		
	load_layout()

func _process(_delta):
	$sliders.visible = selected_button != null
	$sliders_text.visible = selected_button != null
	
	if !reset_timer.is_stopped():
		var progress = (reset_timer.wait_time - reset_timer.time_left) / reset_timer.wait_time
		var intense = pow(progress, 0.8)
		$ColorRect.modulate.a = intense - 0.25
	else:
		$ColorRect.modulate.a = 0




func apply_editing_state():
	if Globals.editing:
		$background.visible = true
		$ui_interect.visible = true
		$ui_down.visible = true
		$ui_up.visible = true
		$texto.visible = true
		$sair.visible = true
		$anim.play("default")
	else:
		$background.visible = false
		$ui_interect.visible = false
		$ui_down.visible = false
		$ui_up.visible = false
		$texto.visible = false
		$sair.visible = false


func get_default_position(name):
	return default_positions.get(name, Vector2.ZERO)

func reset_layout():
	#print("RESETANDO LAYOUT")
	for child in get_children():
		if child is TouchScreenButton:
			child.position = get_default_position(child.name)
			# reseta a escala original do _ready()
			if original_scales.has(child.name):
				child.scale = original_scales[child.name]
				
			if original_opacity.has(child.name):
				child.modulate.a = original_opacity[child.name]
				child.self_modulate.a = original_opacity[child.name]


func _input(event):
	
	
	if not Globals.editing:
		return
		
	if event is InputEventScreenTouch:
		if event.pressed:
			var button_hit = false
			var slider_hit = false
			for child in get_children():
				if child is TouchScreenButton:
					if is_touching_button(child, event.position):
						$SFX_select.play()
						
						dragging_node = child
						selected_button = child
						
						button_hit = true
						
						var base_scale = original_scales[child.name]
						var base_opacity = original_opacity[child.name]
						$sliders/tamanho.value = child.scale.x / base_scale.x * 50
						$sliders/opacidade.value = child.modulate.a / base_opacity * 50
						break
			for s in $sliders.get_children():  # pega todos os sliders dentro do container
				if s is Control and s.get_global_rect().has_point(event.position):
					slider_hit = true
					break
			
			# só deseleciona se não tocou nem botão nem slider
			if not button_hit and not slider_hit:
				selected_button = null
		else:
			dragging_node = null
			
	elif event is InputEventScreenDrag and dragging_node:
		dragging_node.position += event.relative
		
		var screen_size = get_viewport().get_visible_rect().size
		var size = dragging_node.texture_normal.get_size() * dragging_node.scale
		var half_size = size * 0.5
		var pos = dragging_node.position
		
		var margin_left = -20.0
		var margin_top = -20.0
		var margin_right = 40.0
		var margin_bottom = 40.0
		
		pos.x = clamp(
			pos.x,
			half_size.x + margin_left,
			screen_size.x - half_size.x - margin_right
		)
		
		pos.y = clamp(
			pos.y,
			half_size.y + margin_top,
			screen_size.y - half_size.y - margin_bottom
		)
		
		dragging_node.position = pos
	
	
	if event is InputEventScreenTouch:
		$texto.visible = false
		if event.pressed and Globals.editing:
			$resetTimer.start()
		
		else:
			$resetTimer.stop()
	
	if dragging_node != null:
		$resetTimer.stop()
		return

func is_touching_button(button: TouchScreenButton, touch_pos: Vector2) -> bool:
	if selected_button:
		$sliders.visible = true
		$sliders_text.visible = true
	
	if button.texture_normal == null:
		return false
		
	var radius = button.texture_normal.get_width() * 0.7 * button.scale.x
	var size = button.texture_normal.get_size() * button.scale
	var center = button.global_position + size * 0.5
	
	return center.distance_to(touch_pos) <= radius


func _on_reset_timer_timeout() -> void:
	#print("resetou")
	$SFX_reset.play()
	reset_layout()


func _on_tamanho_value_changed(value: float) -> void:
	var fator = value / 50.0
	var base = original_scales[selected_button.name]
	$resetTimer.stop()
	
	if selected_button:
		selected_button.scale = base * fator
	
	$sliders/tamanho.focus_mode = Control.FOCUS_NONE
	$sliders/opacidade.focus_mode = Control.FOCUS_NONE

func _on_opacidade_value_changed(value: float) -> void:
	var fator = value / 50.0
	var base = original_opacity[selected_button.name]
	$resetTimer.stop()
	
	if selected_button:
		selected_button.modulate.a = base * fator
		if selected_button.name == "ui_interect" or selected_button.name == "ui_down" or selected_button.name == "ui_up":
			selected_button.self_modulate.a = base * fator
		
	$sliders/tamanho.focus_mode = Control.FOCUS_NONE
	$sliders/opacidade.focus_mode = Control.FOCUS_NONE


func _on_sair_pressed() -> void:
	Globals.editing = false
	$SFX_select.play()
	save_layout()
	Transition.trocar_de_cena("res://scenes/opções.tscn")


func save_layout():
		var layout_data = {}
		
		for child in get_children():
			if child is TouchScreenButton:
				var opacity_value
				
				
				if child.name == "ui_interect" or child.name == "ui_down" or child.name == "ui_up":
					opacity_value = child.self_modulate.a
				else:
					opacity_value = child.modulate.a
				
				layout_data[child.name] = {
					"position": child.position,
					"scale": child.scale,
					"opacity": opacity_value
				}
		
		ConfigGlobal.dados.layout = layout_data
		ConfigGlobal.salvar_no_disco()

func load_layout():
	if not ConfigGlobal.dados.has("layout"):
		return
		
	var layout_data = ConfigGlobal.dados.layout
	
	for child in get_children():
		if child is TouchScreenButton and layout_data.has(child.name):
			child.position = layout_data[child.name]["position"]
			child.scale = layout_data[child.name]["scale"]
			
			var opacity = layout_data[child.name]["opacity"]
			
			if child.name == "ui_interect" or child.name == "ui_down" or child.name == "ui_up":
				child.self_modulate.a = opacity
			else:
				child.modulate.a = opacity
