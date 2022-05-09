extends Control

var id

func _ready():
	AudioManager.stop_music()
	setup("1")

func setup(level_id):
	name = "Level %s" % id
	
	#load the tilemap for level id
	load_map(level_id)
	load_ui()

func load_map(level_id):
	var map = load("res://Scenes/Map/Map%s.tscn" % level_id)
	add_child(map.instance())
	
func load_ui():
	var menu = load("res://Scenes/Menu/LevelMenu.tscn")
	$CanvasLayer.add_child(menu.instance())
	

	
