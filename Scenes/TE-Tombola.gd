extends Node3D

@export var auto_modulation: bool = false
@onready var mainShape = $MainShape
@onready var area = $Area3D
@onready var timer: Timer = $NotesEmitter/Timer
var mainShapeSpeed : int = 0

@onready var ui: Control = $UI

func _ready() -> void:
	if auto_modulation:
		ui.visible = false
		if auto_modulation:
			play_random_anim()



func play_random_anim():
	var t = create_tween()
	t.parallel().tween_property(self, "mainShapeSpeed", randf() * 100.0 , randf_range(1,10)) # slider speed 0 - 100
	t.parallel().tween_method(_on_angle_value_changed, previous_angle_value, randf() , randf_range(1,10)) # slider angle 0 - 1
	t.parallel().tween_method(_on_ball_amount_value_changed, previous_ball_amount_value, randf_range(0.1,4), randf_range(1,10)) # ball amount 0 - 100
	t.parallel().tween_method(_on_gravity_value_changed, previous_gravity_value, randf(), randf_range(1,10)) # slider gravity 0 - 1
	await t.finished
	if auto_modulation: play_random_anim()

func _process(delta):
	mainShape.rotate_z( -delta * mainShapeSpeed * 0.025)

var previous_gravity_value: = 0.0
func _on_gravity_value_changed(value):
	previous_gravity_value = value
	area.gravity = value * 9.8


var previous_angle_value: = 0.0
func _on_angle_value_changed(value):
	previous_angle_value = value
	var value_lerped = lerp(0, 90, value)
	for s in mainShape.get_children():
		if s is Node3D:
			s.rotation_degrees =  Vector3(0,0,value_lerped) + s.init_angle

func _on_rotation_speed_value_changed(value):
	mainShapeSpeed = value

var previous_ball_amount_value: = 0.0
func _on_ball_amount_value_changed(value: float) -> void:
	if value <= 0.1:
		timer.stop()
	else:
		timer.start()
		previous_ball_amount_value = 4.1 - (value * 4.0)
		timer.wait_time = 4.1 - (value * 4.0)


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.double_tap:
			toggle_auto_mode()
	elif event.is_action_pressed("toggle_auto_mode"):
		toggle_auto_mode()

func toggle_auto_mode():
	ui.visible = !ui.visible
	if ui.visible ==  false:
		auto_modulation = true
		play_random_anim()
	else:
		auto_modulation = false
