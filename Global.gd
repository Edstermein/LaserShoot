extends Node

var platform := [
	preload("res://Boss/Boss.tscn"),
	preload("res://Classic/Platform.tscn"),
	preload("res://Spooky/Spooky.tscn"),
	preload("res://Stay in the Circle/Circle_platform.tscn"),
	preload("res://The 3 Sisters/Sisters_platform.tscn")
]

# The more levels, the harder the enemies are and complicated  things get
var spawn_frequency_on_timer = 2 # affects whether to dd more enemies or not. 
var level = 0 
var boss_health = 500
var regular_foe_health = 10
var score_keep = false


func level_develop():
	level += 1
	boss_health += 500
	regular_foe_health += 2
	if level == 7:
		spawn_frequency_on_timer = 1
	
func change_scene():
	level_develop()
	var chosen = randi() % platform.size()
	var tochoose = platform[chosen]
	#change_scene_to() is for packaged scenes(like those in preload. 
	#change_scene() requires String. Just commit preload() for this function
	get_tree().change_scene_to(tochoose) 


