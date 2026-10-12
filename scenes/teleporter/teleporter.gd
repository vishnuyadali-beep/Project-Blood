extends Area2D
class_name Teleporter
var player_inside = null
@export var destination: Teleporter
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_inside != null and Input.is_action_just_pressed("interact"):
		player_inside.global_position = destination.get_node("ExitPoint").global_position


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_inside = body


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_inside = null
