@tool
extends Label

const BuildInfo := preload("res://addons/export-build-info/build_info.gd")


func _ready():
	var build_version = ProjectSettings.get_setting(BuildInfo.BUILD_INFO_VERSION)
	var build_commit = ProjectSettings.get_setting(BuildInfo.BUILD_INFO_COMMIT)
	var build_date = ProjectSettings.get_setting(BuildInfo.BUILD_INFO_DATE)

	if build_version and build_commit and build_date:
		set_text("v%s @ %s\n%s" % [build_version, build_commit.left(7), build_date])
	else:
		set_text("")
