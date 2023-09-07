extends Node

@onready var easy_menu: Control = get_node(^"%EasyMenu")
@onready var title: Label = get_node(^"%EasyMenu/Content/Title")


func _ready():
	title.set_text(&"Greeter")
	easy_menu.connect(&"start_game_pressed", _on_Menu_start_game_pressed)


func _on_Menu_start_game_pressed():
	await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
