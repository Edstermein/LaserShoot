extends Node2D

export var timer = 1
var preloaded_enemies = preload("res://Enemies/Regulars.tscn")

func _ready():
	randomize()
	$Timer.start(Global.spawn_frequency_on_timer)

func _on_Timer_timeout():

	var enemypreload = preloaded_enemies.instance()
	var xPos = rand_range($pos1.position.x, $pos2.position.x) # allows for random spawn within the two positions
	enemypreload.position = Vector2(xPos,self.position.y) # preload spawn within desired coordinates
	get_tree().current_scene.add_child(enemypreload)
