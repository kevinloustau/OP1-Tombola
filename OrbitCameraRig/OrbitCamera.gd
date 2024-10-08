extends Node3D

# Control variables
@export var maxPitch : float = 0
@export var minPitch : float = -45
@export var maxZoom : float = 20
@export var minZoom : float = 4
@export var zoomStep : float = 2
@export var zoomYStep : float = 0.15
@export var verticalSensitivity : float = 0.002
@export var horizontalSensitivity : float = 0.002
@export var camYOffset : float = 2
@export var camLerpSpeed : float = 16.0
@export var target: NodePath

# Private variables
var _camTarget : Node3D = null
var _cam : Camera3D
var _curZoom : float = 0.0
var _moveCam =  false

func _ready() -> void:
	# Setup node references
	_camTarget = get_node(target)
	_cam = get_node("Camera3D")
	
	# Setup camera position in rig
	_cam.translate(Vector3(0,camYOffset,maxZoom))
	_curZoom = maxZoom

func _input(event) -> void:
	if event is InputEventMouseMotion and _moveCam:
		# Rotate the rig around the target
		rotate_y(-event.relative.x * horizontalSensitivity)
		rotation.x = clamp(rotation.x - event.relative.y * verticalSensitivity, deg_to_rad(minPitch), deg_to_rad(maxPitch))
		orthonormalize()
		
	if event is InputEventMouseButton:
		# Change zoom level on mouse wheel rotation
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP and _curZoom > minZoom:
				_curZoom -= zoomStep
				camYOffset -= zoomYStep
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and _curZoom < maxZoom:
				_curZoom += zoomStep
				camYOffset += zoomYStep
			if event.button_index == MOUSE_BUTTON_MIDDLE:
				_moveCam = true
		else :
			_moveCam = false

func _process(delta) -> void:
	# zoom the camera accordingly
	_cam.set_position(_cam.position.lerp(Vector3(0,camYOffset,_curZoom),delta * camLerpSpeed))
	# set the position of the rig to follow the target
	set_position(_camTarget.global_transform.origin)
