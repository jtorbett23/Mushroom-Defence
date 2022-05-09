extends Sprite

var type 
var cost
var targets = []
var can_attack = true
var reload_time = 3

var attack_timer = Timer.new()

func _ready():
	$Radius.connect("area_entered", self, "set_attackable")
	$Radius.connect("area_exited", self, "remove_attackable")
	attack_timer.connect("timeout", self, "reset_attack")
	attack_timer.one_shot = true
	add_child(attack_timer)

func reset_attack():
	can_attack = true

func _process(delta):
	if(targets.size() > 0 and can_attack):
		var unit = targets[0].get_parent().get_parent()
		Events.emit_signal("user_action", "Unit Defeated", unit)
		unit.queue_free()
		can_attack = false
		attack_timer.start(reload_time)
	
func set_attackable(target):
	targets.append(target)
	
func remove_attackable(target):
	targets.erase(target)

func setup(id):
	if(id == 0):
		type = "Arrow"
		cost = 20
		$Radius/CollisionShape2D.shape.radius = 50
