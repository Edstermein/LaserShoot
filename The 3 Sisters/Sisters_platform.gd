extends Node2D

var value = 0

func all_destroyed():
	Global.change_scene()


func _on_Sister_turrets_destroyedturret(number_of_times):
	value += number_of_times
	if value >= 3:
		all_destroyed()
