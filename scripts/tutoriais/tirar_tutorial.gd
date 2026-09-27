extends Area2D

var fade_in_execut := false

@export var tutorial : Control = null
@export var anim : AnimationPlayer = null

func _ready():
	tutorial.visible = false
	anim.stop()

func _process(_delta: float) -> void:
	if Globals.tutoriais["tutorial_escada"] == true:
		tutorial.visible = true
		if not fade_in_execut:
			anim.play("fade_in")
			fade_in_execut = true
	else:
		anim.play("fade_out")
		await anim.animation_finished
		tutorial.visible = false


func _on_body_entered(body: Node2D) -> void:
	anim.play("fade_out")
	await anim.animation_finished
	tutorial.visible = false
	Globals.tutoriais["tutorial_escada"] = false
