extends KinematicBody2D

var Life = 100
var score = 0

var vel = Vector2()
var speed = 70

signal hit_recommend()

func _physics_process(delta): 
	if Input.is_action_pressed("up"):
		vel.y -= speed
	elif Input.is_action_pressed("down"):
		vel.y += speed
	elif Input.is_action_pressed("left"):
		vel.x -= speed		
	elif Input.is_action_pressed("right"):
		vel.x += speed	
#
	vel.y = lerp(vel.y, 0, 0.05) 
	vel.x = lerp(vel.x, 0, 0.05)	
	vel = move_and_slide(vel) # position bypasses staticbody. move_and_slide() does not

	look_at(get_global_mouse_position()) 
	
func score_a_point(value):
	score += value
	print(score)
	if score >= 5:
		emit_signal("hit_recommend")
	
	
func hurt(damage):
	Life -= damage
	$HUD.hp_bar(Life)
