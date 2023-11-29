extends "res://addons/gd-plug/plug.gd"


func _plugging():
	plug("godot-extended-libraries/godot-debug-menu", {"commit": "2d5d67012c76b272173dcfb4947a65dc385fab94"})
	plug("KoBeWi/Godot-Universal-Fade", {"commit": "ddab6c26cf174fab107fbd6b4e66a5a350e83c22"})
	plug("nisovin/godot-coi-serviceworker", {"commit": "962b1abaf14ac62079b9e5321ef98e6f2b09c96e"})

	# Patched version
	plug("florianvazelle/EasyMenus", {"commit": "3b8602985191f6a128808068d250b5b336d05379"})
