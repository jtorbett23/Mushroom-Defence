extends Panel

onready var options = $Options
onready var main_menu = load("res://Scenes/MainMenu.tscn")

func _ready():
	$"Options/Music Volume".value = AudioManager.current_volume 
	$"Options/Music Volume/Value".text = str(AudioManager.current_volume * 100) + "%" 
	for option in options.get_children():
		match option.get_class():
			"Button":
				option.connect("pressed",self, "select_option" ,[option.name])
			"HSlider":
				option.connect("value_changed", self, "handle_slider", [option])

func handle_slider(value, slider):
	match slider.name:
		"Music Volume":
			AudioManager.set_music_volume(value)
			slider.get_node("Value").text = str(AudioManager.current_volume * 100) + "%" 

func select_option(action):
	match action:
		"Return":
			FancyFade.cross_fade(main_menu.instance())

