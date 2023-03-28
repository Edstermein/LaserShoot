extends KinematicBody2D

var preloaded_enemies = preload("res://Enemies/Mini_pliers.tscn")

var health = Global.regular_foe_health * 3
var player = null
var SPEED = 200
var vel = Vector2()
var hittable = true
var damage = 30

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

	if health <= 0:		#In death, will spawn 3 mini_enemies inside
		spawn_func($spawn1)
		spawn_func($spawn2)
		spawn_func($spawn3)
		queue_free()


func spawn_func(spawn: Position2D):
	var enemypreload = preloaded_enemies.instance()
	enemypreload.position = spawn.global_position
	get_tree().current_scene.add_child(enemypreload)
	
func damaged(value):
	health -= value
	set_modulate(Color(5,2,2,0.9))
	$Timer.start(1)
	
func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))

func _on_hurt_body_entered(body):
	if body.is_in_group("Player"):
		body.hurt(damage)


