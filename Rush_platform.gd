extends Node2D

func _ready():
	$a.play("intro")

func _on_BOSS_dead():
	Global.change_scene()
