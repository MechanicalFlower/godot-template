# SPDX-FileCopyrightText: 2023 Sander Vanhove <sandervhove@gmail.com>
#
# SPDX-License-Identifier: MIT
#
# Source: https://github.com/SanderVanhove/godot-fps-graph-overlay

tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("FPSGraphOverlay", "res://addons/fps_graph_overlay/FPSGraphOverlay.tscn")


func _exit_tree() -> void:
	remove_autoload_singleton("FPSGraphOverlay")
