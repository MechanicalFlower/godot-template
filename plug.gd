extends "res://addons/gd-plug/plug.gd"


func _plugging():
	plug("godot-extended-libraries/godot-debug-menu", {"commit": "e73e8371dc0fed4308b0d7ffb4ba3900da0a93ab"})
	plug("KoBeWi/Godot-Universal-Fade", {"commit": "ddab6c26cf174fab107fbd6b4e66a5a350e83c22"})

	# Patched version
	plug("florianvazelle/EasyMenus", {"commit": "3b8602985191f6a128808068d250b5b336d05379"})