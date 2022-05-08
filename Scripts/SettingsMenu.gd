extends Panel

onready var options = $Options
onready var main_menu = load("res://Scenes/MainMenu.tscn")

func _ready():
	$"Options/Music Volume".value = AudioManager.current_volume
	$"Options/Music Volume/Value".text = str(AudioManager.current_volume)
	for option in options.get_children():
		print(str(option.get_class()))
		match option.get_class():
			"Button":
				option.connect("pressed",self, "select_option" ,[option.name])
			"HSlider":
				option.connect("value_changed", self, "handle_slider", [option])

func handle_slider(value, slider):
	slider.get_node("Value").text = str(value)
	match slider.name:
		"Music Volume":
			AudioManager.set_music_volume(value)

func select_option(action):
	match action:
		"Return":
			FancyFade.cross_fade(main_menu.instance())

