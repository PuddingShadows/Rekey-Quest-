extends Area2D

@onready var anim = $"../AnimationPlayer"
@onready var platform3 = $"../platform3"
@onready var platform4 = $"../platform4"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var strawberry_area = get_node_or_null("../strawberry-area3")
		if strawberry_area:
			$"../strawberry-area3". visible = true
			strawberry_area.get_node("strawberry").visible = true
		platform3.visible = true
		platform4.visible = true
		anim.play("escurecer2")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		var strawberry_area = get_node_or_null("../strawberry-area3")
		if strawberry_area:
			$"../strawberry-area3". visible = false
		platform3.visible = false
		platform4.visible = false
		anim.play("clarear2")
