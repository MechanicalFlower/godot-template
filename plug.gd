extends "res://addons/gd-plug/plug.gd"


func _plugging():
	plug("godot-extended-libraries/godot-debug-menu", {"commit": "e73e8371dc0fed4308b0d7ffb4ba3900da0a93ab"})
	plug("KoBeWi/Godot-Universal-Fade", {"commit": "ddab6c26cf174fab107fbd6b4e66a5a350e83c22"})
	plug("nisovin/godot-coi-serviceworker", {"commit": "de1be2989eda4c7d77a08b8c56cd94c769181c4e"})

	# Patched version
	plug("florianvazelle/EasyMenus", {"commit": "3b8602985191f6a128808068d250b5b336d05379"})

	# Dev
	plug("MechanicalFlower/godot-autogen-docs", {"commit": "223ad605e5b5d1b0c2efb527740851522f345e9b", "dev": true})
