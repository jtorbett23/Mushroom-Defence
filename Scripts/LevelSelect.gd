extends Control

onready var options = $Panel/Options
onready var main_menu = load("res://Scenes/Menu/MainMenu.tscn")
onready var level = load("res://Scenes/Level.tscn")

func _ready():
	var levels = GameData.get_levels()
	for key in levels:
		var level_button = Button.new()
		level_button.text = "Level %s" % key
		level_button.name = key
		$Panel/Options.add_child(level_button)
	
	for option in options.get_children():
		option.connect("pressed",self, "select_option" ,[option.name])
	

func select_option(value):
	match value:
		"Return":
			FancyFade.cross_fade(main_menu.instance())
		_:
			var new_level = level.instance()
			new_level.setup(value)
			FancyFade.cross_fade(new_level)
			
