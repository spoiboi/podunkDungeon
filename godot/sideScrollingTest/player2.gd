extends CharacterBody2D


@export var speed = 300
@export var gravity = 20
@export var jump_force = 500
@export var isForward = true
var horizontal_direction
@export var state = "idle"

func _physics_process(delta):
	
	##applies gravity
	applyGravity()

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
	
	
	
func updateAnimation():
	$AnimationPlayer.play(state)
	
func flipSprite():
	if !isForward:
		$Sprite2D.scale.x = abs($Sprite2D.scale.x) * -1
		$AttackArea.position.x = -33
		$Sprite2D.position.x = -15
	else:
		$Sprite2D.scale.x = abs($Sprite2D.scale.x)
		$AttackArea.position.x = 33
		$Sprite2D.position.x = 15

func assignState():
	if is_on_floor():
		if velocity.x !=0:
			state = "walk"
		else:
			state = "idle"
		if Input.is_action_pressed("attack"):
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
	state = "attack"
	var overlapping_areas = $AttackArea.get_overlapping_areas();
	for area in overlapping_areas:
		#var parent = area.get_parent()
		print("Hit!")

func whenJump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	elif Input.is_action_just_pressed("jump") and velocity.y <= 200:
		velocity.y = -jump_force
