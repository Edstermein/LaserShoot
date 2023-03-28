extends Node2D


func _ready():
	randomize()
	$a.play("bounce")

func _on_Atk_body_entered(body):

	Global.Player_atk += 10
	$Health.queue_free()
	$Casino.queue_free()
	$Atk/atk.text = "Atk grew to " + str(Global.Player_atk)
	result_taken()


func _on_Health_body_entered(body):
	Global.Player_maxhealth += 20
	Global.Player_health += 40
	$Atk.queue_free()
	$Casino.queue_free()
	$Health/restore.text = "Health grew to " + str(Global.Player_maxhealth)
	result_taken()

func _on_Casino_body_entered(body):
	var result = randi() % 101
	
	if 0 <= result and result >= 20:
		Global.Player_atk += 10
		$Casino/CASINO.text = "Atk grew to " + str(Global.Player_atk)
	elif 20 < result and result >= 40:
		Global.Player_maxhealth += 40
		Global.Player_health += Global.Player_maxhealth
		$Casino/CASINO.text = "Health grew to " + str(Global.Global.Player_maxhealth)
	else:
		$Casino/CASINO.text = "SORRY BUD BUT YOU GOT NOTHING"
	$Health.queue_free()
	$Atk.queue_free()
	
	result_taken()
		
func result_taken():
	$End_timer.start(2)

func _on_End_timer_timeout():
	Global.change_scene()	
