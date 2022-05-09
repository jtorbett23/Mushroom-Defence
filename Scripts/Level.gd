extends Control

var id

var map
var menu 

var wave_no = 1
var wave_max = 3
var gold_count = 100

var waves = [5,10,15]

func _ready():
	setup(1)
	AudioManager.stop_music()
	Events.connect("user_action", self, "handle_user_action")


func setup(level_id):
	#load the tilemap for level id
	load_map(level_id)
	load_ui()

func handle_user_action(action, payload):
	match action:
		"Place Tower":
			gold_count -= payload.cost
			menu.update_text({"gold": gold_count})
			map.add_tower(payload)
		"Trigger Wave":
			trigger_wave()


func trigger_wave():
	menu.update_text({ "wave": "%s/%s" % [wave_no + 1, wave_max]})
	print("trigger wave")
	var spawn_timer = Timer.new()
	add_child(spawn_timer)
	var no_units = waves[wave_no - 1]
	wave_no += 1	
	var thread  = Thread.new()
	thread.start(self, "spawn_units", no_units)
	thread.wait_to_finish()

var new_unit = load("res://Scenes/Unit.tscn")
func spawn_units(no_units):

	for i in no_units:
		yield(get_tree().create_timer(1.0), "timeout")
		map.add_unit(new_unit.instance())


func end_wave():
	#at end of wave do this
	wave_no += 1
	menu.update_text({ "wave": "%s/%s" % [wave_no, wave_max]})

func load_map(level_id):
	map = load("res://Scenes/Map/Map%s.tscn" % level_id).instance()
	add_child(map)
	
func load_ui():
	menu = load("res://Scenes/Menu/LevelMenu.tscn").instance()
	menu.update_text({"gold": gold_count, "wave": "%s/%s" % [wave_no, wave_max]})
	$CanvasLayer.add_child(menu)
	

	
