extends CharacterBody2D

@export var gravity = 200
func _physics_process(delta):
	velocity.y =0
	velocity.x = 50
	if velocity.x > 0:
		$AnimatedEnemy.play("walk")
	else:
		$AnimatedEnemy.play("walk_back")
	
	if !is_on_floor():
		velocity.y+=gravity
	move_and_slide()
