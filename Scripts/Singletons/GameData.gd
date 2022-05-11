extends Node


var levels = {
	1 : {
		"waves": [5,10,15],
		"gold": 50
	}
}

var towers = {
	"1": {
		"type": "Ballista",
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
