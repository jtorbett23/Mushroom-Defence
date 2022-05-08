extends Control

var id

func _ready():
	AudioManager.stop_music()
	setup("1")

func setup(map_id):
	id = map_id
	name = "Level %s" % id
	$Title.text = "Level %s" % id
	
	#load the tilemap for level id
	load_map(id)

func load_map(id):
	var map = load("res://Scenes/Map/Map%s.tscn" %id)
	add_child(map.instance())
	
