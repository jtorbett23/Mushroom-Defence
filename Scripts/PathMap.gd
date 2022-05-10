extends TileMap

var no_tower_area = load("res://Scenes/Map/NoTower.tscn")

func _ready():
	var tiles = get_used_cells()
	for tile in tiles:
		var pos = map_to_world(tile)
		var new_no_tower_area = no_tower_area.instance()
		new_no_tower_area.position = pos
		add_child(new_no_tower_area)
