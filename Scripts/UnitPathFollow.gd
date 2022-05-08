extends PathFollow2D

export var run_speed = 100
func _process(delta):
	set_offset(get_offset() + run_speed * delta)
	if(unit_offset == 1):
		print("path complete")
		get_tree().queue_delete(self)
	
