extends Control

var longestrun = Global.level

func _ready():
	$Highestlvl.text = "Highest level: " + str(longestrun)

func _on_Button_pressed():
	get_tree().change_scene("res://Classic/Platform.tscn")
	Global.level = 0 # reset the level values again once you reset
	
