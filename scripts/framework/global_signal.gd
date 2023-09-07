extends Node

var _signals: Dictionary = {}


func add_listener(signal_name: StringName, callable: Callable):
	if not _signals.has(signal_name):
		_signals[signal_name] = []

	_signals[signal_name].append(callable)


func trigger_signal(signal_name: StringName, arguments: Array = []):
	if not _signals.has(signal_name):
		printerr("Unknown signal: '" + signal_name + "'")
		return

	for callable in _signals[signal_name]:
		callable = callable as Callable  # cast
		if callable.is_valid():
			callable.callv(arguments)
