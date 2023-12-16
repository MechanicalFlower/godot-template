extends "res://addons/gd-plug/plug.gd"


func _plugging():
	plug("godot-extended-libraries/godot-debug-menu", {"commit": "9d36ea23661d095198ff7fcfff2715172f73c983"})
	plug("KoBeWi/Godot-Universal-Fade", {"commit": "f091514bba652880f81c5bc8809e0ee4498988ea"})
	plug("nisovin/godot-coi-serviceworker", {"commit": "de1be2989eda4c7d77a08b8c56cd94c769181c4e"})

	# Patched version
	plug("florianvazelle/EasyMenus", {"commit": "3b8602985191f6a128808068d250b5b336d05379"})
