extends CanvasLayer


func _ready():
	$Lvl_Number.text = str(Global.level) #Convert to int to string for .text to accept
	$TextureProgress.max_value = Global.Player_maxhealth
	$TextureProgress.value = Global.Player_health

#func score_update(value):
#	_ready()
	
func hp_bar(life):
	$TextureProgress.value = life
	if life <= 0:
		get_tree().change_scene("res://Other_screens/GameOver.tscn")
