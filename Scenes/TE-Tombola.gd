extends Node3D

@onready var mainShape = $MainShape
@onready var area = $Area3D
@onready var timer: Timer = $NotesEmitter/Timer
var mainShapeSpeed : int = 0

func _process(delta):
	mainShape.rotate_z( -delta * mainShapeSpeed * 0.025)

func _on_gravity_value_changed(value):
	area.gravity = value * 9.8

func _on_angle_value_changed(value):
	var value_lerped = lerp(0, 90, value)
	for s in mainShape.get_children():
		if s is Node3D:
			s.rotation_degrees =  Vector3(0,0,value_lerped) + s.init_angle

func _on_rotation_speed_value_changed(value):
	mainShapeSpeed = value

func _on_ball_amount_value_changed(value: float) -> void:
	if value < 10:
		timer.stop()
	else:
		print(value)
		timer.start()
		timer.wait_time = 100 / (value * 4)
		print("timer.wait_time: " , 100 / value)
