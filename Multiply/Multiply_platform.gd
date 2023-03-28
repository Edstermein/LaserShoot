extends Node2D





# Called when the node enters the scene tree for the first time.
func _ready():
	$a.play("intro")
	$End_timer.start(Global.universal_end_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_End_timer_timeout():
	Global.change_scene()
