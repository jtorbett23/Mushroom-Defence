extends Control

onready var options = $Panel/Options
onready var towers = $Panel/Towers
onready var level_select = load("res://Scenes/Menu/LevelSelect.tscn")
onready var settings = load("res://Scenes/Menu/SettingsMenu.tscn")

func _ready():
	AudioManager.set_music("menu")
	for option in options.get_children():
		match option.get_class():
			"Button":
				option.connect("pressed",self, "select_option" ,[option.name])
	for tower_button in towers.get_children():
		match tower_button.get_class():
			"Button":
				tower_button.connect("pressed",self, "select_option" ,[tower_button.name])	

func select_option(action):
	match action:
		"Return":
			FancyFade.cross_fade(level_select.instance())
		"Settings":
			var settings_instance = settings.instance()
			$"../".add_child(settings_instance)
		"Arrow":
			print("makey arrow tower")
		"Start":
			print("trigger the next wave")
