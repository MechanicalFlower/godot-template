@tool

class_name Greeter

extends Label3D

@export var player_name: String


func _ready() -> void:
	set_text("Hello " + player_name + "!")
