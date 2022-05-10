extends PathFollow2D

export var run_speed = 100
var value = 2

func _process(delta):
	set_offset(get_offset() + run_speed * delta)
	if(unit_offset == 1):
		Events.emit_signal("action", "Unit Finish", self)
		
	
