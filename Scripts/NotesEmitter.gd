extends Node3D

@onready var particule := preload("res://Scenes/Particle.tscn")
@onready var timer := $Timer

func _ready():
	timer.start()

func _on_Timer_timeout():
	create_particle(self)
	remove_if_far(self)

func create_particle(parent:Node3D):
	var p = particule.instantiate()
	parent.add_child(p)

func remove_if_far(parent: Node3D):
	for node in parent.get_children():
		if node is Node3D:
			if node.get_position().distance_to(Vector3.ZERO) > 10:
				node.queue_free()
