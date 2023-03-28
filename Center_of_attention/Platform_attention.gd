extends Node2D


var in_light = false
var timer_duration = 3
var player
var damage = 15

var maxleft = -589
var maxright = 2021
var maxup = -651
var maxdown = 1492

func _ready():
	$a.play("fade intro")
	if get_tree().has_group("Player"):
		player = get_tree().get_nodes_in_group("Player")[0]
	$Spotlight.global_position = $Player.global_position #ensure player is in spotlight when you start
	$Timer.start(timer_duration)
	
	randomize() # Ensure Spotlight will go in random directions
	set_tween() #Initialize moving the spotlight
	$End_game.start(Global.universal_end_timer)#After 60 minutes, tranisiton to next game
	

func set_tween():
	var new_pos = Vector2(rand_range(maxleft,maxright),rand_range(maxup,maxdown)) #NEVER GO PAST the borders
	$Tween.interpolate_property($Spotlight,"position",$Spotlight.global_position,new_pos,5.0,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	
func _on_Tween_tween_completed(object, key): # KEEEP SPOTLIGHT GOING
	set_tween()
	


func _on_Spotlight_body_entered(body): #when in spotlight, timer stops 
	$Timer.stop() #stops and resets the timer
	in_light = true

func _on_Spotlight_body_exited(body): #leaving spotlight then timer goes
	in_light = false
	$Timer.start(timer_duration) #If not in circle in the duration of the timer designated, then inflict damage

func _process(delta):
	if in_light : #If you are not in spotlight for a designated amount of time, you inflict damage
		return
	elif in_light == false and $Timer.is_stopped():
		if player != null:
			player.hurt(damage)
		$Timer.start()

func _on_End_game_timeout():
	Global.change_scene()
