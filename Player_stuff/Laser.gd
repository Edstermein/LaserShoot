extends RayCast2D

var is_casting := false setget set_is_casting

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO
	
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		self.is_casting = event.pressed #set bool conditionof funciton set_is_casting() true or not relative to press
		
func _physics_process(delta):
	var cast_point = cast_to
	force_raycast_update()
	
	$Collisionparticles.emitting = is_colliding() # set particle on or off relative to mouse press
	
	if is_colliding(): # give new point location to collission particles relative to raycast contact
		cast_point = to_local(get_collision_point()) #gets info on where raycast collisison hit
		$Collisionparticles.global_rotation = get_collision_normal().angle() #have particles project an outward sprea form object
		$Collisionparticles.position = cast_point 
		
	$Line2D.points[1] = cast_point 
	$Beamparticles.position = cast_point * 0.5
	$Beamparticles.process_material.emission_box_extents.x = cast_point.length() * 0.5
	
	$New_hitter.position = cast_point - Vector2(10,0)# cast_point overlaps shapes too much so had to make adjustments for detection
	
	
	if $New_hitter.get_collider_shape() == 0 and $New_hitter.get_collider() != null:
		#collider_shape seems to be zero on imported nodes but seems to add in value on local created collisions. 
		#Hence get_collider_shape() is zero to only detect imported nodes like "Regulars" and "Lights"
		#get_collider is 1= null to ensure "has_methods" below do not work with a null body
		if $New_hitter.get_collider().has_method("hit"):
			$New_hitter.get_collider().hit()			
		if $New_hitter.get_collider().has_method("damaged"):
			$New_hitter.get_collider().damaged(5) #collider gets the body of the object interacting
			

func set_is_casting(cast: bool):
	is_casting = cast
	$Beamparticles.emitting = is_casting
	$Castingparticles.emitting = is_casting # set particle on or off relative to mouse press
	
	$New_hitter.enabled = is_casting

	if is_casting:
		appear()
	else:
		$Collisionparticles.emitting = false # turn off collisison particles once you stop firing
		disappear()
	set_physics_process(is_casting)
	
func appear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D,"width",0,10.0,0.2)
	$Tween.start()
	
func disappear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D,"width", 10.0,0, 0.1)
	$Tween.start()	

		
		

		

