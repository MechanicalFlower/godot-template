# SPDX-FileCopyrightText: 2023 Florian Vazelle <florian.vazelle@vivaldi.net>
#
# SPDX-License-Identifier: MIT

class_name Greeter

extends Label3D

export(String) var player_name


func _ready() -> void:
	set_text("Hello " + player_name + "!")
