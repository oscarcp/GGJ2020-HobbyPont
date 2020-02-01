
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
