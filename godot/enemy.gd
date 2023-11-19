extends CharacterBody2D

@export var gravity = 200
var facingRight = -1
var speed = 50
func _physics_process(delta):
	velocity.y = 0
	velocity.x = speed*facingRight
	
	$animator.play("walk")
	if !is_on_floor():
		velocity.y+=gravity
	move_and_slide()
	
	if !$sight.is_colliding() and is_on_floor():
		flip()
	
	var overlapping_areas = $hitbox.get_overlapping_areas();
	for area in overlapping_areas:
		area.get_parent().stun()
		
func die():
	queue_free()


func flip():
	facingRight = facingRight*-1
	scale.x=abs(scale.x)*-1
	
func isEnemy():
	return true
	
