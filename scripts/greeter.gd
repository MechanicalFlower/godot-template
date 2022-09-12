class_name Greeter

extends Label3D

export(String) var player_name


func _ready() -> void:
	set_text("Hello " + player_name + "!")


func _process(delta: float) -> void:
	# Some test variables, usually you'd get them from game logic
	var time = OS.get_ticks_msec() / 1000.0

	DebugDraw.set_text("Time", time)
	DebugDraw.set_text("Frames drawn", Engine.get_frames_drawn())
	DebugDraw.set_text("FPS", Engine.get_frames_per_second())
	DebugDraw.set_text("delta", delta)
