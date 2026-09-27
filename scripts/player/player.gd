extends CharacterBody2D

@onready var collision := $"collision player"

enum State {
	IDLE,
	RUN,
	JUMP,
	FALL,
	DEAD,
	RESPAWN
	}

var state = State.IDLE


var red_key: bool = false
var spawn_point := Vector2()
var is_dead := false
var is_respawning := false
var deaths = 1
var can_use_ladder1 = false
var can_use_ladder2 = false
var ladder_target = Vector2.ZERO

const SPEED = 150.0
const JUMP_VELOCITY = -310.0
const GRAVITY = 1000.0

@onready var SFX_jump = $SFX_jump
@onready var SFX_death = $SFX_death

var is_jumping := false
var was_on_floor := false
var last_y_velocity := 0.0
var tempo_pular = false
var pulo_pitch := 1.0
var DustScene = preload("res://actors/dust.tscn")



@onready var animation := $Anim as AnimatedSprite2D

func set_state(new_state):
	if state == new_state:
		return
	
	state = new_state
	
	match state:
		State.IDLE:
			animation.play("idle")
		
		State.RUN:
			animation.play("run")
		
		State.JUMP:
			animation.play("jump")
		
		State.FALL:
			animation.play("fall")
		
		State.DEAD:
			animation.play("morte")
		
		State.RESPAWN:
			animation.play("renascer")

func _physics_process(delta: float) -> void:
	match state:
		State.DEAD:
			return
		State.RESPAWN:
			return
	
	#usar escada
	handle_ladder()
	#coyote time
	handle_coyote_time()
	#gravidade
	handle_gravity(delta)
	#pulo
	handle_jump()
	#movimentação
	handle_movement()
	
	#update_state()
	
	last_y_velocity = velocity.y
	move_and_slide()
	
	handle_landing()
	#tocar som de passo quando tiver andando
	handle_footsteps()

func handle_ladder():
	if can_use_ladder1 and Input.is_action_just_pressed("down"):
		global_position = ladder_target
		jump()
	elif can_use_ladder2 and Input.is_action_just_pressed("up"):
		global_position = ladder_target
		jump()

func handle_coyote_time():
	if was_on_floor and not is_jumping and is_on_floor():
		$Timer.start()
		tempo_pular = true

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
		if velocity.y < 0:
			set_state(State.JUMP)
		
		elif velocity.y > 0:
			set_state(State.FALL)
		
		if velocity.y < 0 and not Input.is_action_pressed("jump"):
			velocity.y *= 0.7
			pulo_pitch += delta * 2.0
			SFX_jump.pitch_scale = pulo_pitch

func handle_jump():
	if Globals.console_open:
		return
	
	if Input.is_action_just_pressed("jump"):
		jump()
		
	elif is_on_floor():
		is_jumping = false

func jump():
	if is_on_floor() or tempo_pular:
		pulo_pitch = 0.7
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		tempo_pular = false
		$Timer.stop()
		spawn_dust("jump_dust")
		SFX_jump.pitch_scale = pulo_pitch
		SFX_jump.play()

func handle_movement():
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		
		if is_on_floor():
			set_state(State.RUN)
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if is_on_floor():
			set_state(State.IDLE)

func handle_landing():
	if is_on_floor() and not was_on_floor and last_y_velocity > 300:
		spawn_dust("fall_dust")
		
		if velocity.x != 0:
			set_state(State.RUN)
		else:
			set_state(State.IDLE)
		
		is_jumping = false
	was_on_floor = is_on_floor()

func handle_footsteps():
	if is_on_floor() and animation.animation == "run":
		if $Footstep.is_stopped():
			$Footstep.start()
			tocar_som_passo()
	else:
		$Footstep.stop()
		$SFX_passos.stop()

func tocar_som_passo():
	$SFX_passos.pitch_scale = randf_range(0.8, 1.2) # Muda o tom um pouco
	$SFX_passos.play()


func morrer():
	if is_dead:
		return
	
	if !Globals.god_mode:
		is_dead = true
		set_state(State.DEAD)
		
		SFX_death.play()
		get_parent().deaths += deaths

func renascer():
	global_position = spawn_point
	is_dead = false
	is_respawning = true
	set_state(State.RESPAWN)

func _on_anim_animation_finished() -> void:
	match $Anim.animation:
		"morte":
			renascer()
			
		"renascer":
			is_respawning = false
			set_state(State.IDLE)

func spawn_dust(anim_name: String):
	var d := DustScene.instantiate() as AnimatedSprite2D
	
	if anim_name == "jump_dust":
		d.scale = Vector2(1.0, 1.0)
	else:
		d.scale = Vector2(0.9, 0.6)
	
	
	var shape_height = collision.shape.extents.y
	var y_offset: float = shape_height
			
	if anim_name == "fall_dust":
		y_offset -= 6   
	else:
		y_offset -= 4   # jump_dust

	d.global_position = global_position + Vector2(0, y_offset)
	
	get_parent().add_child(d)
	d.play(anim_name)
	d.animation_finished.connect(d.queue_free)


func _on_timer_timeout() -> void:
	tempo_pular = false

func _on_footstep_timeout() -> void:
	tocar_som_passo()

func _ready() -> void:
	spawn_point = global_position
