extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jumps = 0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimationSprite.animation = "falling"
	else: 
		if velocity.x == 0:
			$AnimationSprite.animation = "idle"
		else:
			$AnimationSprite.animation = "running"
		jumps = 0

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or jumps < 2):
		$AnimationSprite.animation = "jumping"
		velocity.y = JUMP_VELOCITY
		jumps += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	var is_running = Input.is_action_pressed("run")
	
	if direction:
		print(direction)
		velocity.x = direction * (SPEED + (150 if is_running else 0))
	else:
		velocity.x = move_toward(velocity.x, 0, 5)
		
	$AnimationSprite.flip_h = velocity.x < 0

	move_and_slide()
