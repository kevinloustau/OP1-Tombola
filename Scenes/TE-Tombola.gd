extends Spatial

onready var mainShape = $MainShape
onready var area = $Area
var mainShapeSpeed : int = 0

func _process(delta):
	mainShape.rotate_z( -delta * mainShapeSpeed * 0.025)

func _on_gravity_value_changed(value):
	area.gravity = value * 9.8

func _on_angle_value_changed(value):
	var value_lerped = lerp(0, 90, value)
	for s in mainShape.get_children():
		if s is Spatial:
			s.rotation_degrees =  Vector3(0,0,value_lerped) + s.init_angle

func _on_rotation_speed_value_changed(value):
	mainShapeSpeed = value
