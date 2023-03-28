extends Node2D


func _ready():
	$a.play("intro")
	$End_timer.start(Global.universal_end_timer)


func _on_End_timer_timeout():
	Global.change_scene()
