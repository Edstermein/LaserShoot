extends Node2D

var score = 0

func _ready():
	$a.play("intro")
#	Global.score_keep = true
	$End_timer.start(Global.universal_end_timer)


#func _on_Player_hit_recommend():
#	$Player.score = 0 # reset after reaching amount. Move to next challenge
#	Global.score_keep = false # turn off ability to score_keep to transition to next mode
	
	

func _on_End_timer_timeout():
	Global.change_scene()
