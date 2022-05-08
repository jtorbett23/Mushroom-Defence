extends Control

var id

func setup(id):
	id = id
	name = "Level %s" % id
	$Panel/Title.text = "Level %s" % id
