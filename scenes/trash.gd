extends Area2D

var collected = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_Area2D_body_entered(body: Node) -> void:
	if body == get_node("/root/World/robo/KinematicBody2D") and not collected:
		get_node("AnimationPlayer").play("dissapear")
		collected = 1
