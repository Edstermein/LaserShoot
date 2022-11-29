extends StaticBody2D

#timer in auto switch and off or hit when contact by laser
export var off = 5
var hittable = true 

func _ready():
	$Light2D.texture_scale = 0.2
	$Light2D.energy = 0.5
	hittable = true
	
func hit():
	if hittable:
		$Light2D.texture_scale = 1.2
		$Light2D.energy = 0.9
		$Timer.start(5)
		hittable = false #ensure you can onlyactivate it once. Can activate it again after light turns "off"

func _on_Timer_timeout():
	_ready() # returns to "off" state after timer with light "on"
