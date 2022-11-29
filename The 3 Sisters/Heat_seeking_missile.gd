extends Area2D


# Declare member variables here. Examples:
var player = null
var direction = Vector2()
var SPEED = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(4)
	if get_tree().has_group("Player"):
		player = get_tree().get_nodes_in_group("Player")[0]

func _physics_process(delta):
	if player != null:
		direction = (player.global_position - self.global_position).normalized() * SPEED
	position += direction
	
	
func _on_Timer_timeout():
	queue_free()


func _on_Heat_seeking_missile_body_entered(body):
	if body.is_in_group("Player"):
		body.hurt(5)
		queue_free()
	else:
		queue_free()
