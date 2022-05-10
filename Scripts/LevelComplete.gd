extends Control

onready var options = $Panel/Options
onready var level_select = load("res://Scenes/Menu/LevelSelect.tscn")
onready var level = load("res://Scenes/Level.tscn")

func _ready():
	for option in options.get_children():
		option.connect("pressed",self, "select_option" ,[option.name])

func select_option(value):
	match value:
		"Return":
			FancyFade.cross_fade(level_select.instance())
		"Next":
			var new_level = level.instance()
			new_level.setup(value)
			FancyFade.cross_fade(new_level)
