extends KinematicBody2D

var health = Global.regular_foe_health
var player = null
var SPEED = 200
var vel = Vector2()
var hittable = true
var damage = 10

func _ready():
	var hittable = true
	var tree = get_tree() # to call tree
	if tree.has_group("Player"): # ensure "player" is created an added in a group called "Player"
		player = tree.get_nodes_in_group("Player")[0] #detects player without using area2d


func _physics_process(delta):
	if player != null:
		vel = (player.global_position - self.global_position).normalized() * SPEED
	else:
		vel = Vector2.ZERO

	vel = move_and_slide(vel)

	if health <= 0:		
		if Global.score_keep == true: #Will only work on cetain game modes that demand score keeping
			player.score_a_point(1)
		queue_free()

func damaged(value):
	health -= value
	set_modulate(Color(5,2,2,0.9))
	$Timer.start(1)

func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.hurt(damage)
