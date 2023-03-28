extends Node

var platform := [
	preload("res://Boss/Boss.tscn"),
	preload("res://Classic/Platform.tscn"),
	preload("res://Spooky/Spooky.tscn"),
	preload("res://Stay in the Circle/Circle_platform.tscn"),
	preload("res://The 3 Sisters/Sisters_platform.tscn"),
	preload("res://Multiply/Multiply_platform.tscn"),
	preload("res://Rush/Rush_platform.tscn"),
	preload("res://Stay in the Circle/Circle_platform.tscn")
]

#keep some stats like health consistent regardless of scene transition
var Player_maxhealth = 100
var Player_health = 100 #current_health
var Player_atk = 5

# The more levels, the harder the enemies are and complicated  things get
var spawn_frequency_on_timer = 2 # affects whether to dd more enemies or not. 
var level = 0 
var boss_health = 500
var regular_foe_health = 10
var universal_end_timer = 30
var previous_chosen = -1 #-1 to ensure index 0 can still be used first

var bonus_level_show = 0 # when reach 5, show bonus level

func level_develop(): # increase level number and difficulty
	level += 1
	boss_health += 300
	regular_foe_health += 2
	
	if level == 7:
		spawn_frequency_on_timer = 1
	
func change_scene():
	level_develop()
	var chosen = randi() % platform.size()

	bonus_level_show = (bonus_level_show + 1) % 6 # if bonus level time, cancel other under it for now

	if bonus_level_show == 5: # every 5 levels, spawn to a bonus stage for perks
		level -= 1
		get_tree().change_scene("res://Bonus/Bonus_stage.tscn")
		return

	if previous_chosen != chosen: #prevent repeating stages
		previous_chosen = chosen
	else:
		chosen = (chosen + 1)  % platform.size()
	var tochoose = platform[chosen]
	#change_scene_to() is for packaged scenes(like those in preload. 
	#change_scene() requires String. Just commit preload() for this function
	get_tree().change_scene_to(tochoose) 



