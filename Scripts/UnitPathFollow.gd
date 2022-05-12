extends PathFollow2D

export var run_speed = 100
var value = 2

func _process(delta):
	set_offset(get_offset() + run_speed * delta)
	if(unit_offset == 1):
		Events.emit_signal("action", "Unit Finish", self)
		
func _ready():
	$Sprite/Area.connect("area_entered", self, "on_area_entered")	

func on_area_entered(body):
	if(body.is_in_group("Projectile")):
		body.queue_free()
		Events.emit_signal("action", "Unit Defeated", self)
