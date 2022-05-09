extends Node2D


func add_tower(tower):
	$Towers.add_child(tower)

func add_unit(unit):
	$Path2D.add_child(unit)
