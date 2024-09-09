extends Node3D

@export var files: Array[AudioStream] # (Array, AudioStream)

@onready var audio_player := $AudioStreamPlayer
@onready var ball := $CSGMesh3D

func _ready():
	audio_player.stream = files[randi() % files.size()]

func play_sound():
	audio_player.play()
