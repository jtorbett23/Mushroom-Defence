extends Control

var id

func _ready():
	AudioManager.stop_music()
	setup("1")

func setup(map_id):
	id = map_id
	name = "Level %s" % id
	
	#load the tilemap for level id
	load_map(id)
	
	load_ui()

func load_map(id):
	var map = load("res://Scenes/Map/Map%s.tscn" %id)
	add_child(map.instance())
	
func load_ui():
	pass
	
