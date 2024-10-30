extends Node2D

@onready var platform_parent = $PlatformParent

var camera_scene = preload("res://scenes/game_camera.tscn")
var platform_scene = preload("res://scenes/Platform.tscn")

var camera = null

func _ready():
	camera = camera_scene.instantiate()
	camera.setup_camera($player)
	add_child(camera)
	
	# Generate the Ground
	var viewport_size = get_viewport_rect().size
	var platform_width = 136
	var ground_layer_platform_count = (viewport_size.x / platform_width) + 1
	
	var ground_layer_y_offset = 62
	for i in range(ground_layer_platform_count):
		var ground_location = Vector2(i * platform_width ,viewport_size.y - ground_layer_y_offset)
		create_platorm(ground_location)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func create_platorm(location: Vector2):
	var platform = platform_scene.instantiate()
	platform.global_position = location
	platform_parent.add_child(platform)
	return platform
	
