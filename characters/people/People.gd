extends KinematicBody2D

const DIRECTION_LEFT = -1
const DIRECTION_RIGHT = 1

const UP = Vector2(0, -1)
const GRAVITY = 9
const PUSH_SPEED = 50
const JUMP_HEIGHT = -200

# Player
var direction = DIRECTION_RIGHT
var velocity = Vector2()
# Camera
var zoom_factor = 1.0
var zoom_speed = 10.0

func get_input():
	velocity.y += GRAVITY
	
	# Camera controls
	if Input.is_action_pressed("camera_in"):
		zoom_factor -= 0.01
	elif Input.is_action_pressed("camera_out"):
		zoom_factor += 0.01
	
	# Player movement
	if Input.is_action_pressed("steer_left"):
		if $AnimatedSprite.scale.x > 0:
			direction = DIRECTION_LEFT
			$AnimatedSprite.scale.x = -1
	elif Input.is_action_pressed("steer_right"):
		if $AnimatedSprite.scale.x < 0:
			direction = DIRECTION_RIGHT
			$AnimatedSprite.scale.x = 1
	else:
		velocity.x = lerp(velocity.x, 0, 0.01)
	
	# Push
	if Input.is_action_just_pressed("push_right"):
		velocity.x += PUSH_SPEED * direction
		
	# Jump
	if Input.is_action_just_released("trick_down"):
		if is_on_floor():
			velocity.y = JUMP_HEIGHT

func _physics_process(delta):
	get_input()
	_input_tests()
	velocity = move_and_slide(velocity, UP)

func _input_tests():
	# Brake
	if Input.is_action_pressed("brake"):
		print("brake")
		
	# Camera In
	if Input.is_action_pressed("camera_in"):
		print("camera_in")
	
	# Camera Out
	if Input.is_action_pressed("camera_out"):
		print("camera_out")
		
	# Camera Reset
	if Input.is_action_pressed("camera_reset"):
		print("camera_reset")
		
	# Goto Marker
	if Input.is_action_pressed("goto_marker"):
		print("goto_marker")
		
	# Grab Left
	if Input.is_action_pressed("grab_left"):
		print("grab_left")
	
	# Grab Right
	if Input.is_action_pressed("grab_right"):
		print("grab_right")
		
	# Place
	if Input.is_action_pressed("place"):
		print("place")
		
	# Place Marker
	if Input.is_action_pressed("place_marker"):
		print("place_marker")
		
	# Push Left
	if Input.is_action_pressed("push_left"):
		print("push_left")
		
	# Push Right
	if Input.is_action_pressed("push_right"):
		print("push_right")
		
	# Steer Left
	if Input.is_action_pressed("steer_left"):
		print("steer_left")
		
	# Steer Right
	if Input.is_action_pressed("steer_right"):
		print("steer_right")
		
	# Steer Up
	if Input.is_action_pressed("steer_up"):
		print("steer_up")
		
	# Steer Down
	if Input.is_action_pressed("steer_down"):
		print("steer_down")
		
	# Trick Down
	if Input.is_action_pressed("trick_down"):
		print("trick_down")
		
	# Trick Up
	if Input.is_action_pressed("trick_up"):
		print("trick_up")
		
	# Trick Left
	if Input.is_action_pressed("trick_left"):
		print("trick_left")
		
	# Trick Right
	if Input.is_action_pressed("trick_right"):
		print("trick_right")
		
	# Start
	if Input.is_action_pressed("start"):
		print("start")
		
	# Select
	if Input.is_action_pressed("select"):
		print("select")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var zoom = $Camera2D.get_zoom()
	zoom.x = lerp(zoom.x, zoom.x * zoom_factor, zoom_speed * delta)
	zoom.y = lerp(zoom.y, zoom.x * zoom_factor, zoom_speed * delta)
	zoom_factor = lerp(zoom_factor, 1.0, 0.1)
	
	$Camera2D.set_zoom(zoom)
