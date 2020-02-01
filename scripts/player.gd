
extends RigidBody2D

# Member variables
export var player_speed = 200
export var player_accel = 10
export var extra_gravity = 500
export var jump_force = 800

var raycast_ground = null
var current_speed = Vector2(0, 0)
var MOVE_RIGHT = Input.is_action_pressed("ui_right")
var MOVE_LEFT = Input.is_action_pressed("ui_left")
var JUMP = Input.is_action_pressed("ui_up")

# State machine for the player
var PLAYERSTATE_PREV = ""
var PLAYERSTATE = ""
var PLAYERSTATE_NEXT = ""
var ORIENTATION_PREV = ""
var ORIENTATION = ""
var ORIENTATION_NEXT = ""

func move_player(speed, accel, delta):
	"""Movement of the player

	This function will provide an acceleration factor to the movement
	and it will also organize a bit the calls for movement.

	Args:
		speed - Current speed of the player
		accel - Acceleration factor
		delta - The computing delta
	"""
	current_speed.x = lerp(current_speed.x, speed, accel * delta)
	set_linear_velocity(Vector2(current_speed.x, get_linear_velocity().y))

func is_on_ground():
	"""Check collision on ground"""
	if raycast_ground.is_colliding():
		return true
	else:
		return false

func _ready():
	"""Initialization here"""
	# Get the raycast and remove the player collision from it
	raycast_ground = get_node("RayCast2D")
	raycast_ground.add_exception(self)

	set_physics_process(true)
	set_applied_force(Vector2(0, extra_gravity))

func _physics_process(delta):
	"""Main loopwhere our custom code runs"""
	# States
	PLAYERSTATE_PREV = PLAYERSTATE
	PLAYERSTATE = PLAYERSTATE_NEXT
	ORIENTATION_PREV = ORIENTATION
	ORIENTATION = ORIENTATION_NEXT

	# Because we want to keep track in realtime of the keys
	# we have to redefine them in the loop
	MOVE_RIGHT = Input.is_action_pressed("ui_right")
	MOVE_LEFT = Input.is_action_pressed("ui_left")
	JUMP = Input.is_action_pressed("ui_up")

	if MOVE_LEFT == true:
		move_player(-player_speed, player_accel, delta)
	elif MOVE_RIGHT == true:
		move_player(player_speed, player_accel, delta)
	else:
		move_player(0, player_accel, delta)

	if is_on_ground():
		if JUMP:
			print("JUMP")
			set_axis_velocity(Vector2(0, -jump_force))




extends KinematicBody2D

export (int) var ACCELERATION = 512
export (int) var MAX_SPEED = 64
export (float) var FRICTION = 0.25
export (int) var GRAVITY = 200
export (int) var JUMP_FORCE = 128

var motion = Vector2.ZERO

func _physics_process(delta):
var input_vector = get_input_vector()
apply_horizontal_force(input_vector, delta)
apply_friction(input_vector)
jump_check()
apply_gravity(delta)
move()

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
