extends Node2D

var pts = 0

var on_circle = false
var relocation_times = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_process(false)

func _process(delta):
	var max_pts = 300
	
	pts +=1 	
	
	if pts >= max_pts:
		pts = 0
		relocation_times +=1
		var PosX = rand_range($left.position.x,$right.position.x)
		var PosY = rand_range($top.position.y,$bottom.position.y)
		$Circle.position = Vector2(PosX,PosY)	
		if relocation_times >= 3:
			print("done!")
			Global.change_scene()	
			

func _on_Area2D_body_entered(body):
	set_process(true)


func _on_Area2D_body_exited(body):
	set_process(false)
