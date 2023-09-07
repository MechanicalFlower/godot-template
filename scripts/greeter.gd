@tool

class_name Greeter

extends Label3D

@export var player_name: String


func _ready() -> void:
	await get_tree().process_frame
	await Fade.fade_in(1, Color.BLACK, "Diamond", false, false).finished

	set_text("Hello " + player_name + "!")
