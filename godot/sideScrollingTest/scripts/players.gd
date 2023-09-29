extends CharacterBody2D

@export var speed = 300
@export var gravity = 20
@export var jump_force = 500

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 500:
			velocity.y = 500

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_force
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	if velocity.x != 0:
		if velocity.x > 0:
			$PlayerAnimation.play("walk")
		else:
			$PlayerAnimation.play("walk_back")
	if horizontal_direction == 0 or !is_on_floor():
		$PlayerAnimation.stop()
	move_and_slide()

