extends CharacterBody2D

@export var speed = 300
@export var gravity = 20
@export var jump_force = 500
var isForward = true


func _physics_process(delta):
	##applies gravity
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 500:
			velocity.y = 500

	
	##gets direction of player
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	
	if horizontal_direction == -1:
		isForward = false
	elif horizontal_direction == 1:
		isForward = true
	
	##applies movement
	velocity.x = speed * horizontal_direction
	
	##animates on floor
	if velocity.x != 0 and is_on_floor():
		if isForward:
			$PlayerAnimation.play("walk")
		else:
			$PlayerAnimation.play("walk_back")
			
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
#		if isForward:
#			$PlayerAnimation.play("jumping")
#		else:
#			$PlayerAnimation.play("jumping_back")
	##animates in air	
	if !is_on_floor():
		if isForward:
			$PlayerAnimation.play("jumping")
		else:
			$PlayerAnimation.play("jumping_back")
			
			
	
			
	##stops animation		
	if velocity.x==0 and is_on_floor():
		if isForward:
			$PlayerAnimation.play("walk")
		else:
			$PlayerAnimation.play("walk_back")
		$PlayerAnimation.stop()
		
		
	##Attacking
#	if Input.is_action_just_pressed("attack"):
#		if isForward:
#			$PlayerAnimation.play("attack")
#			$AttackAnimation.play("attack")
#		else:
#			$PlayerAnimation.play("attack_back")
#			$AttackAnimationBack.play("attack")
#			for
#		$AttackAnimation.play("blank")
#		$AttackAnimationBack.play("blank")
#		$AttackAnimation.stop()
#		$AttackAnimationBack.stop()
#		$PlayerAnimation.stop()
	##updates screen	
	move_and_slide()

