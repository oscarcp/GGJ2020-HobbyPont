# Global script of the game containing main functions and variables
extends Node

var current_scene = null
var FORCE_QUIT = Input.is_action_pressed("FORCE_QUIT")

# Save data
# The save data contains the following parameters
# level (str): path to the current level the player is on.
# firstrun (bool): Is it the first time that the game runs?
# In GNU/Linux the savegame is stored in ~/.godot/app_userdata/White/
# In Windows 10 %(HOMEDIR)\AppData\Roaming\Godot\app_userdata\White
var save_data = {"level":"levels/level1.tscn", "firstrun":true}
var savegame = File.new()
var save_path = "user://savegame.bin"

func _ready():
	set_process(true)
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	check_savegame()

# Scene loading
func goto_scene(path):
	call_deferred("_deferred_goto_scene",path)

func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)

# Savegame functionality
func check_savegame():
	if not savegame.file_exists(save_path):
		savegame.open_encrypted_with_pass(save_path, File.WRITE, OS.get_unique_ID())
		savegame.store_var(save_data)
		savegame.close()

func get_screenshot():
	# TODO: Get a screenshot
	pass

func _process(delta):
	FORCE_QUIT = Input.is_action_pressed("FORCE_QUIT")
	if FORCE_QUIT == true:
		self.get_tree().quit()
