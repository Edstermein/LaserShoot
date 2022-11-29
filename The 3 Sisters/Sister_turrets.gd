extends StaticBody2D

var open = false
var player = null

var max_health = Global.boss_health
var current_health = Global.boss_health

var fire_once = true
var projectile = preload("res://The 3 Sisters/Heat_seeking_missile.tscn")
var bullet = preload("res://Boss/Bullets.tscn")


var targetted_position = Vector2()

signal destroyedturret(number_of_times)

#test if basic funmental work for turret
# add turret detectng firing
func _ready():
	print(max_health)
	randomize()
	open = false # defult closed and unattackable
	$Timer.start(2) # transition to open and close relative to time
	
	var tree = get_tree() # to call tree
	if tree.has_group("Player"): # ensure "player" is created an added in a group called "Player"
		player = tree.get_nodes_in_group("Player")[0] #detects player without using area2d
		
func _process(delta):	
	if open:
		$head.visible = true	
		if fire_once:
			var rand_num = randi() % 2 
			if rand_num == 0:
				heat_missile()
			elif rand_num == 1:
				bullet_fire()
			fire_once = false
	else:
		$head.visible = false
		fire_once = true
		
func bullet_fire():
	var BULLET = bullet.instance()
	BULLET.position = self.position
	var Pos = (player.global_position - self.global_position).normalized() * 6
	BULLET.direction = Pos
	get_parent().add_child(BULLET)
func heat_missile():

	var heat_missile = projectile.instance()
	heat_missile.position = self.position
	get_parent().add_child(heat_missile)
		
func damaged(value):
	if open: # only when the turret is open can you damage it
		current_health -= value
		current_health = clamp(current_health,0, max_health)
		$Hp_bar.value = current_health



func _on_Timer_timeout():
	if $Hp_bar.value != 0:
		$Timer.start()
		open = not open
	else:
		emit_signal("destroyedturret",1)
		queue_free()
