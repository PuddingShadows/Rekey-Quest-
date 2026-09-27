extends CanvasLayer

@onready var death_counter = $deaths_counter as Label
@onready var timet_counter = $timer_counter as Label

func _ready():
	death_counter.text = str("X%02d" % get_parent().deaths)
	
	for key in get_parent().get_children():
		if key.has_signal("key_collected"):
			key.key_collected.connect(_on_key_collected)
	
	for strawberry in get_parent().get_children():
		if strawberry.has_signal("strawberry_collected"):
			strawberry.strawberry_collected.connect(_on_strawberry_collected)

func _process(_delta: float) -> void:
	death_counter.text = str("X%02d" % get_parent().deaths)
	$timer_counter.start_time()


func _on_key_collected():
	atualizar_icones_chaves(true)

func _on_strawberry_collected():
	atualizar_icones_morangos(true)

func atualizar_icones_chaves(red_key: bool):
	if red_key:
		$chave_escondida.visible = false
		$chave_encontrada.visible = true
	else:
		$chave_escondida.visible = true
		$chave_encontrada.visible = false

func atualizar_icones_morangos(strawberry: bool):
	if strawberry:
		$morango_escondido.visible = false
		$morango_encontrado.visible = true
	else:
		$morango_escondido.visible = true
		$morango_encontrado.visible = false
