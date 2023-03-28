extends KinematicBody2D

var BULLETS = preload("res://Boss/Bullets.tscn")
var max_health = Global.boss_health # sets maximum amount of health
var current_health = Global.boss_health

var player = null
signal life(life_left)
var vel = Vector2()
var SPEED = 50
var damage = 30
	
func _ready():
	var tree = get_tree()
	if tree.has_group("Player"): # ensure "player" is created an added in a group called "Player"
		player = tree.get_nodes_in_group("Player")[0] #detects player without using area2d
	$Timer.start(0.4)
	
func _physics_process(delta):
	
	self.rotate(.08) #rotates the node in radians. Process keeps this process more continuous

	if player != null:
		vel = (player.global_position - self.global_position).normalized() * SPEED
	vel = move_and_slide(vel)
	
func bullet_spawn():
	var bullets = BULLETS.instance()
	bullets.position = self.position
	bullets.rotation = self.rotation
	bullets.direction = Vector2(1,0)
	
	var bullets2 = BULLETS.instance()
	bullets2.position = self.position
	bullets2.rotation = self.rotation
	bullets2.direction = Vector2(0,1)
	
	var bullets3 = BULLETS.instance()
	bullets3.position = self.position
	bullets3.rotation = self.rotation
	bullets3.direction = Vector2(-1,0)
	
	var bullets4 = BULLETS.instance()
	bullets4.position = self.position
	bullets4.rotation = self.rotation
	bullets4.direction = Vector2(0,-1)
	
	get_parent().add_child(bullets)
	get_parent().add_child(bullets2)
	get_parent().add_child(bullets3)
	get_parent().add_child(bullets4)
	

func damaged(value):
	current_health -= value	
	current_health = clamp(current_health,0,max_health) #clamp is (value, value's minimum, value's maxiumum)
	emit_signal("life",current_health) #left with String is the name of the signal. Right is the variable adeded to signal
	
	
func _on_Timer_timeout():
	bullet_spawn()


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.hurt(damage)
