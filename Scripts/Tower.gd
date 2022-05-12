extends Sprite

var type 
var cost
var targets = []
var can_attack = true
var reload_time 
var offset_angle = 180
var projectile = load("res://Scenes/Tower/Projectile.tscn")

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
	var tower_data = GameData.get_tower(id)
	type = tower_data.type
	cost = tower_data.cost
	$Radius/CollisionShape2D.shape.radius = tower_data.radius
	reload_time = tower_data.reload_time

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
	var b = projectile.instance()
	get_tree().get_root().add_child(b)
	b.transform = self.global_transform
	can_attack = false
	attack_timer.start(reload_time)


func set_attackable(target):
	targets.append(target.get_parent().get_parent())
	
func remove_attackable(target):
	targets.erase(target.get_parent().get_parent())
