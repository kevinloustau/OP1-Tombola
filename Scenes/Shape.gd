extends MeshInstance

var init_angle: Vector3

func _ready():
	init_angle = self.rotation_degrees


func _on_Area_body_entered(body):
	if body is RigidBody:
		body.play_sound()
		
