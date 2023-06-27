tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("FPSGraphOverlay", "res://addons/fps_graph_overlay/FPSGraphOverlay.tscn")


func _exit_tree() -> void:
	remove_autoload_singleton("FPSGraphOverlay")
