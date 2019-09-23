extends KinematicBody2D

const DIRECTION_LEFT = -1
const DIRECTION_RIGHT = 1

const UP = Vector2(0, -1)
const GRAVITY = 9
const PUSH_SPEED = 70
const BURST_SPEED = 50
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
	if Input.is_action_pressed("ui_up"):
		zoom_factor -= 0.01
	if Input.is_action_pressed("ui_down"):
		zoom_factor += 0.01
	
	# Player movement
	if Input.is_action_pressed("ui_left"):
		if $Sprite.scale.x > 0:
			direction = DIRECTION_LEFT
			#velocity.x = -BURST_SPEED
			$Sprite.scale.x = -1
	elif Input.is_action_pressed("ui_right"):
		if $Sprite.scale.x < 0:
			direction = DIRECTION_RIGHT
			#velocity.x = BURST_SPEED
			$Sprite.scale.x = 1
	else:
		velocity.x = lerp(velocity.x, 0, 0.01)
	
	# Push
	if Input.is_action_just_pressed("push"):
		velocity.x += PUSH_SPEED * direction
	
	#if Input.is_action_pressed("push"):
	#	velocity.x += PUSH_SPEED * direction
		
	# Jump
	if Input.is_action_just_pressed("ui_select"):
		if is_on_floor():
			velocity.y = JUMP_HEIGHT
	
	# Correct facing position based on speed
	if (velocity.x > 100.0):
		direction = DIRECTION_RIGHT
		$Sprite.scale.x = 1
	
	#print(velocity.x)

func _physics_process(delta):
	get_input()

	velocity = move_and_slide(velocity, UP)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Update zoom
	#var camera = get_node("Camera2D")
	var zoom = $Camera2D.get_zoom()
	#print(zoom)
	zoom.x = lerp(zoom.x, zoom.x * zoom_factor, zoom_speed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoom_factor, zoom_speed * delta)
	$Camera2D.set_zoom(zoom)
