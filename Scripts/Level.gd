extends Node

var id

var map
var menu 

var wave_no = 1
var waves 
var wave_max
var gold_count



func _ready():
	setup(1)
	AudioManager.stop_music()
	# warning-ignore:return_value_discarded
	Events.connect("action", self, "handle_action")


func setup(level_id):
	#load the tilemap for level id
	waves = GameData.get_level_data(level_id, "waves")
	gold_count = GameData.get_level_data(level_id, "gold")
	wave_max = waves.size()
	load_map(level_id)
	load_ui()

func handle_action(action, payload):
	match action:
		"Place Tower":
			gold_count -= payload.cost
			menu.update_text({"gold": gold_count})
			map.add_tower(payload)
		"Trigger Wave":
			trigger_wave()
		"Unit Defeated":
			gold_count += payload.value
			menu.update_text({"gold": gold_count})
			map.remove_unit(payload)
			if(map.get_unit_count() == 0):
				end_wave()
		"Unit Finish":
			#damage player
			map.remove_unit(payload)
			if(map.get_unit_count() == 0):
				end_wave()
			


func trigger_wave():
	if(wave_no <= wave_max):
		var spawn_timer = Timer.new()
		add_child(spawn_timer)
		var no_units = waves[wave_no - 1]
		var thread  = Thread.new()
		thread.start(self, "spawn_units", no_units)
		thread.wait_to_finish()
		menu.disable_wave_button()

var new_unit = load("res://Scenes/Unit.tscn")
func spawn_units(no_units):

	for i in no_units:
		yield(get_tree().create_timer(1.0), "timeout")
		map.add_unit(new_unit.instance())


func end_wave():
	#at end of wave do this
	if(wave_no < wave_max):
		wave_no += 1
		menu.update_text({ "wave": "%s/%s" % [wave_no, wave_max]})
		menu.enable_wave_button()
	elif (wave_no == wave_max):
		var	complete_menu = load("res://Scenes/Menu/LevelComplete.tscn").instance()
		$UI.add_child(complete_menu)
		print("YOU WIN")

func load_map(level_id):
	map = load("res://Scenes/Map/Map%s.tscn" % level_id).instance()
	add_child(map)
	
func load_ui():
	menu = load("res://Scenes/Menu/LevelMenu.tscn").instance()
	menu.update_text({"gold": gold_count, "wave": "%s/%s" % [wave_no, wave_max]})
	$UI.add_child(menu)
	

	
