extends KinematicBody2D

export (int) var ACCELERATION = 512
export (int) var MAX_SPEED = 128
export (float) var FRICTION = 0.25
export (int) var GRAVITY = 400
export (int) var JUMP_FORCE = 350

var motion = Vector2.ZERO

func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_horizontal_force(input_vector, delta)
	apply_friction(input_vector)
	jump_check()
	apply_gravity(delta)
	move()
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		get_node("AnimationPlayer").play("andar")
	else:
		get_node("AnimationPlayer").play("parado")

func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return input_vector

func apply_horizontal_force(input_vector, delta):
	if input_vector.x != 0:
		motion.x += input_vector.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)

func apply_friction(input_vector):
	if input_vector.x == 0 and is_on_floor():
		motion.x = lerp(motion.x, 0, FRICTION)

func jump_check():
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = -JUMP_FORCE

func apply_gravity(delta):
	if not is_on_floor():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMP_FORCE)

func move():
	motion = move_and_slide(motion, Vector2.UP)

