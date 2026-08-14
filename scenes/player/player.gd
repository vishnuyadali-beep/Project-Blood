extends CharacterBody2D
var speed = 300
var dash_speed = 800
var dash_duration = 0.15
var dash_cooldown = 0.5
var is_dashing = false
var can_dash = true
var dash_direction = Vector2.ZERO

func _ready():
	$Sprite2D.play("idle")

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up","move_down")
	
	if is_dashing:
		velocity = dash_direction * dash_speed
	else:
		velocity = direction * speed
		if Input.is_action_just_pressed("dash") and can_dash and direction != Vector2.ZERO:
			_start_dash(direction)
	move_and_slide()

func _start_dash(direction):
	dash_direction = direction
	is_dashing = true
	can_dash = false
	$DashTimer.start()
	$DashCooldownTimer.start()

func _on_dash_cooldown_timer_timeout():
	can_dash = true


func _on_dash_timer_timeout():
	is_dashing = false
