extends Control

onready var options = $Panel/Options
onready var towers = $Panel/Towers
onready var level_select = load("res://Scenes/Menu/LevelSelect.tscn")
onready var settings = load("res://Scenes/Menu/SettingsMenu.tscn")
var selected_tower = null
var can_place_tower = true

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
	
	var no_tower_areas = get_tree().get_nodes_in_group("NoTower")
	for no_tower_area in no_tower_areas:
		no_tower_area.connect("area_entered", self, "no_tower_area_entered")
		no_tower_area.connect("area_exited", self, "no_tower_area_exited")

func no_tower_area_entered(entered_by):
	can_place_tower = false
	$UITower.modulate = Color("ff0000")

func no_tower_area_exited(entered_by):
	$UITower.modulate = Color("ffffff")
	can_place_tower = true

func select_option(action):
	match action:
		"Return":
			FancyFade.cross_fade(level_select.instance())
		"Settings":
			var settings_instance = settings.instance()
			$"../".add_child(settings_instance)
		"Arrow":
			if(selected_tower == "Arrow"):
				selected_tower =  null
				$UITower.visible = false
			else:
				selected_tower = "Arrow"
				$UITower.visible = true
		"Start":
			print("trigger the next wave")

func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton and selected_tower != null:
		if(event.pressed and can_place_tower):
			selected_tower =  null
			$UITower.visible = false
			var new_tower = load("res://Scenes/Tower.tscn").instance()
			new_tower.position = get_viewport().get_mouse_position()
			new_tower.get_node("Area2D").connect("area_entered", self, "no_tower_area_entered")
			new_tower.get_node("Area2D").connect("area_exited", self, "no_tower_area_exited")
			$"/root/Level/Map/Towers".add_child(new_tower)
	elif event is InputEventMouseMotion:
		var offset = Vector2(0,-20)
		$UITower.position = get_viewport().get_mouse_position() + offset
