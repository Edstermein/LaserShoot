extends TextureProgress

var score = 0

func _ready():
	max_value = Global.boss_health
	value = Global.boss_health

func _on_Boss_life(life_left): 
	# boss life is huge(above 100). Thus you see no differene till last minute. Change max value and current value
	#to current boss hp
	value = life_left 
	if  value == 0:
		Global.change_scene()
		queue_free()
		


