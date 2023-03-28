extends Control



var start = Vector2(150,170)
var end = Vector2(150,200)

var first = true
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	tween_set(start,end)


func _on_Start_pressed():
	Global.change_scene()

func tween_set(from,to):
	if first:
		$Tween.interpolate_property($text,"rect_position",from,to,1.0,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	else:
		$Tween.interpolate_property($text,"rect_position",to,from,1.0,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_completed(object, key):	
	first  = not first
	tween_set(start,end)

var indexes = [1,2,3,4,5]
var previous_int = -1
func _on_Options_pressed():
	pass
#	var value = randi() % 5
#	if previous_int != value:
#		previous_int = value
#	else:
#		value = (value + 1) % indexes.size()
#	print(value)
#active_item_panel = (active_item_panel + 1) % HOT_SLOTS
