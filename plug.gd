extends "res://addons/gd-plug/plug.gd"


func _plugging():
	plug(
		"godot-extended-libraries/godot-debug-menu",
		{"commit": "0e5f15217285c76170039c9cefcf79c8ab0ec6b3", "renovate-branch": "master"}
	)
	plug(
		"KoBeWi/Godot-Universal-Fade",
		{"commit": "d3e288d6d9dab100113d671c4d3abb4cf4ac271a", "renovate-branch": "master"}
	)

	# Patched version
	plug(
		"florianvazelle/EasyMenus",
		{"commit": "018ab39001f862abbd6ca424258a9a548589d61c", "renovate-branch": "master"}
	)
	plug(
		"florianvazelle/Log",
		{"commit": "f23215571cb398c16272227130885d867d12cb4b", "renovate-branch": "main"}
	)
