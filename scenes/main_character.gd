extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -700.0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Variable to store the previous direction.
var previous_direction = 0

func _physics_process(delta):
	# Add the gravity.
	if abs(velocity.x) > 1:
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"

	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		# Check if the direction has changed.
		if direction != previous_direction:
			# Update the sprite direction only when the direction changes.
			var isLeft = direction < 0
			sprite_2d.flip_h = isLeft
			previous_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	move_and_slide()
