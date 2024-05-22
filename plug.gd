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
		{"commit": "4eaff9386ac7d0cd93bedba47143728b18b97371", "renovate-branch": "main"}
	)

	# Patched version
	plug(
		"florianvazelle/EasyMenus",
		{"commit": "018ab39001f862abbd6ca424258a9a548589d61c", "renovate-branch": "master"}
	)
	plug(
		"florianvazelle/Log",
		{"commit": "51878aa55c4169f19b2c000f0e53b77439654829", "renovate-branch": "main"}
	)
