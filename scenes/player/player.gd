extends CharacterBody2D
signal hit

var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var dash_time = 0.25
var dash_speed = 800
var dash_direction
var dash_countdown
var dash_cooldown = 1
var cooldown = 0
var is_dashing = false
func _ready():
	$Sprite2D.play("idle")
	

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("dash") and cooldown <= 0 and !is_dashing:
		_start_dash(velocity)
	if is_dashing:
		position += dash_direction * dash_speed * delta
		$Sprite2D.animation = "dash"
		dash_countdown -= delta
		if dash_countdown <= 0:
			cooldown = dash_cooldown
			is_dashing = false
	else:
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		position += velocity * delta
		if velocity.x != 0:
			$Sprite2D.animation = "walk"
			$Sprite2D.flip_v = false
			$Sprite2D.flip_h = velocity.x < 0
		else:
			$Sprite2D.animation = "idle"
	if cooldown > 0:
		cooldown -= delta
func _start_dash(velocity):
	is_dashing = true
	dash_countdown = dash_time
	dash_direction = velocity.normalized()
	
