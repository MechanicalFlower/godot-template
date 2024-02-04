extends EditorExportPlugin

const BuildInfo := preload("res://addons/export-build-info/build_info.gd")


func _export_begin(_features, _is_debug, _path, _flags) -> void:
	BuildInfo.setup_build_info_settings()
