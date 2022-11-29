extends Area2D

var speed = 7
var direction = Vector2(1,0)

func _process(delta):
	self.position += direction.rotated(rotation)

func _on_Bullets_body_entered(body):
	if body.is_in_group("Player"):
		body.hurt(5)
		queue_free()
	else:
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
