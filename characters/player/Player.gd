extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var zoom_factor = 1.0
var zoom_speed = 10.0

func get_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		#velocity.y -= 1
		zoom_factor -= 0.01
	if Input.is_action_pressed("ui_down"):
		#velocity.y += 1
		zoom_factor += 0.01
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	velocity = velocity.normalized() * speed;

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update zoom
	var camera = get_node("Camera2D")
	var zoom = camera.get_zoom()
	print(zoom)
	zoom.x = lerp(zoom.x, zoom.x * zoom_factor, zoom_speed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoom_factor, zoom_speed * delta)
	camera.set_zoom(zoom)
