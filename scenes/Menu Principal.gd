extends Control

func _ready():
	# Center the windows in the screen
	# OS.window_position = (OS.get_screen_size()*0.5 - OS.window_size*0.5)
	pass

func _on_jugar_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/level1.tscn")

func _on_Salir_pressed():
	get_tree().quit()

func _on_Creditos_pressed():
	get_tree().change_scene("res://scenes/Creditos.tscn")



