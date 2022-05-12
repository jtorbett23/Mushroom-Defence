extends Node2D


func add_tower(tower):
	$Towers.add_child(tower)

func add_unit(unit):
	$UnitPath.add_child(unit)

func remove_unit(unit):
	$UnitPath.call_deferred("remove_child", unit)
	unit.queue_free()

func get_unit_count():
	return $UnitPath.get_child_count()
	
