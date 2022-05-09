extends Control

onready var options = $Panel/Options
onready var main_menu = load("res://Scenes/Menu/MainMenu.tscn")

func _ready():
	options.get_node("Music Volume").value = AudioManager.current_volume 
	options.get_node("Music Volume/Value").text = str(AudioManager.current_volume * 100) + "%" 
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
			queue_free()

