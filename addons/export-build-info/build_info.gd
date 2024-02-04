const BUILD_INFO_VERSION := "application/config/version"
const BUILD_INFO_COMMIT := "custom_options/build_info/commit"
const BUILD_INFO_DATE := "custom_options/build_info/date"


static func setup_build_info_settings():
	var output := []

	# Commit Hash
	OS.execute("git", ["log", '--pretty=format:"%H"', "-1"], output, false)
	output[0] = output[0].trim_suffix("\n")
	ProjectSettings.set_as_internal(BUILD_INFO_COMMIT, true)
	ProjectSettings.set_setting(BUILD_INFO_COMMIT, output[0])

	# Datetime
	OS.execute("date", ["+%Y/%m/%d"], output, false)
	output[1] = output[1].trim_suffix("\n")
	ProjectSettings.set_as_internal(BUILD_INFO_DATE, true)
	ProjectSettings.set_setting(BUILD_INFO_DATE, output[1])
