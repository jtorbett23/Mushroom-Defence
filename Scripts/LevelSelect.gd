extends Control

onready var options = $Panel/Options
onready var main_menu = load("res://Scenes/Menu/MainMenu.tscn")
onready var level = load("res://Scenes/Level.tscn")

func _ready():
	for option in options.get_children():
		option.connect("pressed",self, "select_option" ,[option.name])

func select_option(value):
	match value:
		_:
			var new_level = level.instance()
			new_level.setup(value)
			FancyFade.cross_fade(new_level)
		"Return":
			FancyFade.cross_fade(main_menu.instance())
