extends CharacterBody2D

@onready var animated : AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 100.0
var last_direction = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	movement()
		
	
	
func movement():
	var direction = Vector2.ZERO

	if Input.is_action_pressed("back"):
		direction.y -= 1
		animated.play("walk_back")
	elif Input.is_action_pressed("front"):
		direction.y += 1
		animated.play("walk_front")
	elif Input.is_action_pressed("right"):
		direction.x += 1
		animated.flip_h = false
		animated.play("walk")
	elif Input.is_action_pressed("left"):
		direction.x -= 1
		animated.flip_h = true
		animated.play("walk")
		
	if direction != Vector2.ZERO:
		last_direction = direction
			
	if direction == Vector2.ZERO:
		if last_direction == Vector2(0,-1):
			animated.play("idle_back")
		else:
			animated.play("idle_front")  # animation idle par défaut

			
	velocity = direction * SPEED
	move_and_slide()
