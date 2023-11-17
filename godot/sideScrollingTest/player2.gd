extends CharacterBody2D


@export var speed = 300
@export var gravity = 20
@export var jump_force = 500
@export var isForward = true
var horizontal_direction
@export var state = "idle"
var hasJump = true


var checkBoolean = false;
func _physics_process(delta):
	print($hitbox.position.x)
	##applies gravity
	applyGravity()
	$Sprite2D.scale.y = abs($Sprite2D.scale.y)
	##gets direction of player
	horizontal_direction = Input.get_axis("move_left", "move_right")
	if horizontal_direction == -1:
		isForward = false
	elif horizontal_direction == 1:
		isForward = true
	
	##flip sprite
	flipSprite()
	velocity.x = speed * horizontal_direction
	whenJump()
	assignState()
	updateAnimation()
	move_and_slide()
	if is_on_floor():
		hasJump = true
	
	
func updateAnimation():
	$AnimationPlayer.play(state)
	
func flipSprite():
	if !isForward:
		$Sprite2D.scale.x = abs($Sprite2D.scale.x) * -1
		$AttackArea.position.x = -33
		$Sprite2D.position.x = -15
		$hitbox.position.x = 0
		
	else:
		$Sprite2D.scale.x = abs($Sprite2D.scale.x)
		$AttackArea.position.x = 33
		$Sprite2D.position.x = 15
		$hitbox.position.x=0
		

func assignState():
	if Input.is_action_pressed("attack"):
		whenAttack()
	else:
		if is_on_floor():
			if velocity.x !=0:
				state = "walk"
			else:
				state = "idle"
			if Input.is_action_just_pressed("attack"):
				velocity.x=0
				whenAttack()
		else: 
			state = "jump"
		
func applyGravity():
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 500:
			velocity.y = 500
		
func whenAttack():
	velocity.x=0
	state="attack"
	$AnimationPlayer.play("attack")
	var overlapping_areas = $AttackArea.get_overlapping_areas();
	for area in overlapping_areas:
		area.get_parent().die()

func whenJump():
	if Input.is_action_just_pressed("jump") and is_on_floor() and hasJump:
		velocity.y = -jump_force
		hasJump = false
	elif Input.is_action_just_pressed("jump") and velocity.y <= 200 and hasJump:
		velocity.y = -jump_force
		hasJump = false
		
		
func stun():
	var death = false
	var overlapping_areas = $hitbox.get_overlapping_areas();
	for area in overlapping_areas:
		if area.get_parent().isEnemy():
			death = true
	if death:	
		position.x=100
		position.y=100

func die():
	pass
	
func isEnemy():
	return false
