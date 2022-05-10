extends Sprite

var type 
var cost
var targets = []
var can_attack = true
var reload_time = 3
var offset_angle = 180

var attack_timer = Timer.new()

func _ready():
	# warning-ignore:return_value_discarded
	$Radius.connect("area_entered", self, "set_attackable")
	# warning-ignore:return_value_discarded
	$Radius.connect("area_exited", self, "remove_attackable")
	attack_timer.connect("timeout", self, "reset_attack")
	attack_timer.one_shot = true
	add_child(attack_timer)

func setup(id):
	if(id == 0):
		type = "Arrow"
		cost = 20
		$Radius/CollisionShape2D.shape.radius = 50

func reset_attack():
	can_attack = true

func _process(_delta):
	if(targets.size() > 0):
		var unit = targets[0]
		face_target(unit)
		if(can_attack):
			attack(unit)

func face_target(unit):
	var angle_to_target = get_angle_to(unit.position) * (180/PI)
	rotation_degrees += angle_to_target + offset_angle

func attack(unit):
	Events.emit_signal("action", "Unit Defeated", unit)
	can_attack = false
	attack_timer.start(reload_time)


func set_attackable(target):
	targets.append(target.get_parent().get_parent())
	
func remove_attackable(target):
	targets.erase(target.get_parent().get_parent())
