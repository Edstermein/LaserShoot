extends Node2D

var score = 0

func _ready():
	Global.score_keep = true


func _on_Player_hit_recommend():
	$Player.score = 0 # reset after reaching amount. Move to next challenge
	Global.score_keep = false # turn off ability to score_keep to transition to next mode
	Global.change_scene()
	

