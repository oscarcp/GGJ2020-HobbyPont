extends Actor

func _physics_process(delta: float) -> void:
	var direction: = get_direction()
	velocity = speed * direction
	move_and_slide(velocity)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		-1.0 if Input.is_action_just_pressed("ui_up") and is_on_floor() else 1.0
	)
