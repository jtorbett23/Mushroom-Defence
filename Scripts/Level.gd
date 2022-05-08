extends Control

var id

func _ready():
	AudioManager.stop_music()

func setup(id):
	id = id
	name = "Level %s" % id
	$Panel/Title.text = "Level %s" % id
