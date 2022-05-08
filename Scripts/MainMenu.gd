extends Control

onready var options = $Options
onready var level_select = load("res://Scenes/Menu/LevelSelect.tscn")
onready var settings = load("res://Scenes/Menu/SettingsMenu.tscn")

func _ready():
	AudioManager.set_music("menu")
	for option in options.get_children():
		option.connect("pressed",self, "select_option" ,[option.name])

func select_option(action):
	match action:
		"Start":
			FancyFade.cross_fade(level_select.instance())
		"Settings":
			var settings_instance = settings.instance()
			add_child(settings_instance)
		"Quit":
			get_tree().quit()
		
