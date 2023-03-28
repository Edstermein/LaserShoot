extends KinematicBody2D


var vel = Vector2()
var speed = 70

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
	
func hurt(damage):
	Global.Player_health -= damage
	$HUD.hp_bar(Global.Player_health)
	set_collision_layer_bit(0,false) #undetectable
	set_collision_mask_bit(2,false) #can pass through enemies
	set_modulate(Color(1,1,1,0.3))
	$able_to_hit.start(2)


func _on_able_to_hit_timeout():
	set_collision_layer_bit(0,true)
	set_collision_mask_bit(2,true) 
	set_modulate(Color(1,1,1,1))
