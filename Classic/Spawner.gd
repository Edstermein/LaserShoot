extends Node2D

var preloaded_enemies = preload("res://Enemies/Regulars.tscn")

##first

func _ready():
	randomize()
	$Timer.start()
	
func _on_Timer_timeout():
	var enemypreload = preloaded_enemies.instance()
	var xPos = rand_range($top_right.position.x, $top_left.position.x)
	enemypreload.position = Vector2(xPos,$top_right.position.y)
	get_tree().current_scene.add_child(enemypreload)
