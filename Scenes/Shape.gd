extends MeshInstance3D

var init_angle: Vector3

func _ready():
	init_angle = self.rotation_degrees


func _on_Area_body_entered(body):
	if body is RigidBody3D:
		body.play_sound()
