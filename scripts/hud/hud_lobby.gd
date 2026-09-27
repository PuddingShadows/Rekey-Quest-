extends CanvasLayer

@onready var label = $estrelas_counter


@onready var anim: AnimatedSprite2D = $estrelas_sprites
@onready var timer: Timer = $Timer

func _ready():
	timer.one_shot = true
	_start_timer()

func _start_timer():
	timer.wait_time = randf_range(1.0, 10.0)
	timer.start()

func _on_timer_timeout():
	if !anim.is_playing():
		anim.play("idle")

func _on_estrelas_sprites_animation_finished() -> void:
	_start_timer()

func _process(_delta: float) -> void:
	var estrelas = Globals.stars
	atualizar_icones_chaves()
	label.text = str("X%02d" % estrelas)

func atualizar_icones_chaves():
	if Globals.chaves["chave_mundo1_hud"] == true:
		$chave_mundo1.visible = true
		$chave_escondida.visible = false
	else:
		$chave_mundo1.visible = false
		$chave_escondida.visible =  true
