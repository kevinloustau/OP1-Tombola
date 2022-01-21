extends Spatial

onready var particule := preload("res://Scenes/Particle.tscn")
onready var timer := $Timer

func _ready():
	timer.start()
	
func _on_Timer_timeout():
	create_particle(self)
	remove_if_far(self)	

func create_particle(parent:Spatial):
	var p = particule.instance()
	parent.add_child(p)
	
func remove_if_far(parent: Spatial):
	for node in parent.get_children():
		if node is Spatial:
			if node.get_translation().distance_to(Vector3.ZERO) > 10:
				node.queue_free()
		

