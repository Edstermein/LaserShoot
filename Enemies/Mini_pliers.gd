extends KinematicBody2D


var health = Global.regular_foe_health 
var player = null
var SPEED = 400
var vel = Vector2()
var hittable = true
var damage = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	var tree = get_tree()
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]

func _physics_process(delta):
	if player != null:
		vel = (player.global_position - self.global_position).normalized() * SPEED
	else:
		vel = Vector2.ZERO

	vel = move_and_slide(vel)

	if health <= 0:		
		queue_free()

func damaged(value):
	health -= value
	set_modulate(Color(5,2,2,0.9))
	$Timer.start(1)

func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))

func _on_hurt_body_entered(body):
	if body.is_in_group("Player"):
		body.hurt(damage)



