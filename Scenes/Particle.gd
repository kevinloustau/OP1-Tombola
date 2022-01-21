extends Spatial

export(Array, AudioStream) var files

onready var audio_player := $AudioStreamPlayer
onready var ball := $CSGMesh

func _ready():
	audio_player.stream = files[randi() % files.size()]

func play_sound():
	audio_player.play()
