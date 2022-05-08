extends Control

var next_scene = load("res://Scenes/Menu/MainMenu.tscn")

func _unhandled_input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if (event.pressed):
			FancyFade.cross_fade(next_scene.instance())
