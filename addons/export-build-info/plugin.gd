@tool
extends EditorPlugin

const BuildInfo := preload("res://addons/export-build-info/build_info.gd")

var export_plugin := preload("res://addons/export-build-info/export_plugin.gd").new()


func _enter_tree():
	add_export_plugin(export_plugin)

	if Engine.is_editor_hint():
		BuildInfo.setup_build_info_settings()


func _exit_tree():
	remove_export_plugin(export_plugin)
