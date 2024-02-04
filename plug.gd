extends "res://addons/gd-plug/plug.gd"


func _plugging():
	plug(
		"godot-extended-libraries/godot-debug-menu",
		{"commit": "9d36ea23661d095198ff7fcfff2715172f73c983", "renovate-branch": "master"}
	)
	plug(
		"KoBeWi/Godot-Universal-Fade",
		{"commit": "f091514bba652880f81c5bc8809e0ee4498988ea", "renovate-branch": "master"}
	)
	plug(
		"nisovin/godot-coi-serviceworker",
		{"commit": "de1be2989eda4c7d77a08b8c56cd94c769181c4e", "renovate-branch": "main"}
	)

	# Patched version
	plug(
		"florianvazelle/EasyMenus",
		{"commit": "4d960ef6ab9f51a206e2eb40c2cc0b8f8eced71a", "renovate-branch": "master"}
	)
	plug(
		"florianvazelle/Log",
		{"commit": "51878aa55c4169f19b2c000f0e53b77439654829", "renovate-branch": "main"}
	)
