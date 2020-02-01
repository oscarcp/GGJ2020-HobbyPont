extends VBoxContainer

var save_data
var savegame = File.new()
onready var global_node = get_node("/root/global")

func _ready():
	pass

func _on_play_pressed():
	savegame.open_encrypted_with_pass(global_node.save_path, File.READ, OS.get_unique_ID())
	save_data = savegame.get_var()
	savegame.close()
	get_node("../animations").play("fadeout")
	yield( get_node("../animations"), "finished" )
	global_node.goto_scene("res://" + save_data["level"])

func _on_options_pressed():
	print("OPTIONS NOT IMPLEMENTED!")

func _on_exit_pressed():
	self.get_tree().quit()
