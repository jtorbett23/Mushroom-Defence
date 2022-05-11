extends Control

onready var options = $Panel/Options
onready var towers = $Panel/Towers
onready var level_select = load("res://Scenes/Menu/LevelSelect.tscn")
onready var settings = load("res://Scenes/Menu/SettingsMenu.tscn")
var selected_tower = null
var can_place_tower = true
var tower_to_buy = load("res://Scenes/Tower.tscn").instance()
var current_money

func _ready():
	AudioManager.set_music("menu")
	#SETUP THE TOWERS
	for option in options.get_children():
		match option.get_class():
			"Button":
				option.connect("pressed",self, "select_option" ,[option.name])
	$UITower.offset = -self.rect_position
	$UITower/Area2D.position = -self.rect_position
	var no_tower_areas = get_tree().get_nodes_in_group("NoTower")
	for no_tower_area in no_tower_areas:
		no_tower_area.connect("area_entered", self, "no_tower_area_entered")
		no_tower_area.connect("area_exited", self, "no_tower_area_exited")
	var towers = GameData.get_towers()
	for key in towers:
		var tower_button = Button.new()
		tower_button.text = towers[key].type
		tower_button.name = key
		$Panel/Towers.add_child(tower_button)
		var cost_label = Label.new()
		cost_label.text = str(towers[key].cost) + "g"
		cost_label.rect_position = Vector2(tower_button.rect_size.x + 10, tower_button.rect_size.y /4)
		tower_button.add_child(cost_label)
		tower_button.connect("pressed",self, "select_option" ,[tower_button.name])
		

func update_text(data):
	if(data.has("gold")):
		$Panel/Info/Money.text = "Gold: %sg" % data.gold
		current_money = data.gold
	if(data.has("wave")):
		$Panel/Info/Wave.text = "Next Wave: %s" %data.wave

var no_tower_areas_inside = 0
func no_tower_area_entered(entered_by):
	if(entered_by.get_parent().name == "UITower" and $UITower.visible == true):
		no_tower_areas_inside  += 1
		can_place_tower = false
		$UITower.modulate = Color("ff0000")

func no_tower_area_exited(entered_by):
	if(entered_by.get_parent().name == "UITower" and $UITower.visible == true):
		no_tower_areas_inside  -= 1
		if(no_tower_areas_inside  < 1):
			$UITower.modulate = Color("ffffff")
			can_place_tower = true

func select_option(action):
	print(action)
	match action:
		"Return":
			FancyFade.cross_fade(level_select.instance())
		"Settings":
			var settings_instance = settings.instance()
			#attach to canvas layer
			$"../".add_child(settings_instance)
		"Start":
			Events.emit_signal("action", "Trigger Wave", {})
		#it's atower
		_:
			print("wow")
			print(action)
			tower_to_buy.setup(action)
			no_tower_areas_inside  = 1
			can_place_tower = false
			$UITower.modulate = Color("ff0000")
			if(selected_tower == action):
				selected_tower =  null
				$UITower.visible = false
			elif(current_money - tower_to_buy.cost >= 0):
				selected_tower = action
				$UITower.visible = true

func disable_wave_button():
	$Panel/Options/Start.disabled = true

func enable_wave_button():
	$Panel/Options/Start.disabled = false

func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton and selected_tower != null:
		if(event.pressed and can_place_tower):
			var new_tower = load("res://Scenes/Tower.tscn").instance()
			new_tower.setup(selected_tower)
			new_tower.position = get_viewport().get_mouse_position()
			new_tower.get_node("NoTower").connect("area_entered", self, "no_tower_area_entered")
			new_tower.get_node("NoTower").connect("area_exited", self, "no_tower_area_exited")
			Events.emit_signal("action", "Place Tower", new_tower)
			selected_tower =  null
			$UITower.visible = false
	elif event is InputEventMouseMotion:
		$UITower.position = get_viewport().get_mouse_position()
