extends Node


var levels = {
	1 : {
		"waves": [2,10,15],
		"gold": 20
	}
}

var towers = {
	1: {
		"type": "Arrow",
		"reload_time": 3,
		"cost": 20,
		"radius": 50
		
	}
}

func get_level_data(level_id, key):
	return levels[level_id][key]

func get_towers():
	return towers
	
func get_tower(id):
	return towers[id]
