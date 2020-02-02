extends Node2D

var FORCE_QUIT = Input.is_action_pressed("FORCE_QUIT")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	print("WTF")
	if (FORCE_QUIT):
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
