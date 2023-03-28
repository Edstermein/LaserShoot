extends KinematicBody2D
signal dead
var preloaded_enemies = preload("res://Enemies/Mini_pliers.tscn")

var player 
var damage = 15

var health = Global.boss_health
var max_health = Global.boss_health

var vel = Vector2()
var WALK = 100
var RUSH = 100
var last_known_pos = Vector2()

var default_state_time = 2
var rush_wait_time = 2

func _ready():
	if get_tree().has_group("Player"):
		player = get_tree().get_nodes_in_group("Player")[0]
	$default.start(default_state_time)
	
	$HP_bar.max_value = Global.boss_health
	$HP_bar.value = Global.boss_health
	
func _physics_process(delta):
	if health <= 0:
		emit_signal("dead")
		queue_free()
	if $default.is_stopped():
		RUSH()
	else:
		DEFAULT()

func RUSH():
	if $Rush_wait.is_stopped():
		vel = move_and_collide(last_known_pos * RUSH)
		if vel:
			$default.start(default_state_time)
			enemy_spawn($Pos1)
			enemy_spawn($Pos2)
	else:
		vel = Vector2()
		
func enemy_spawn(spawn: Position2D):
	var enemypreload = preloaded_enemies.instance()
	enemypreload.position = spawn.global_position
	get_tree().current_scene.add_child(enemypreload)

	
func DEFAULT():
	last_known_pos  = (player.global_position - self.global_position).normalized() 
	vel = last_known_pos * WALK
	vel = move_and_slide(vel)	

func _on_default_timeout():
	$Rush_wait.start(rush_wait_time)

func damaged(value):
	health -= value
	health = clamp(health,0,max_health) #clamp is (value, value's minimum, value's maxiumum)
	$HP_bar.value = health
	set_modulate(Color(5,2,2,0.9))
	$Timer.start(1)
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.hurt(damage)

func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
