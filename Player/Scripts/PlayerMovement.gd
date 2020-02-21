extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 12
const MAX_SPEED = 8 * GRAVITY
const HORIZONTAL_ACCELERATION = 0.25 * GRAVITY
const VERTICAL_ACCELERATION = 0.035

var direction = 0
var motion = Vector2()

func _process(delta):
	var right = int(Input.is_action_pressed("ui_right"))
	var left = int(Input.is_action_pressed("ui_left"))
	
	direction = right - left

func _physics_process(delta):
	if direction != 0:
		motion.x += direction * HORIZONTAL_ACCELERATION
		motion.y -= MAX_SPEED * VERTICAL_ACCELERATION
		$Sprite.play("Move")
		$Sprite.rotate(direction * PI/6)
	else:
		motion.x -= sign(motion.x) * HORIZONTAL_ACCELERATION
		motion.y += GRAVITY
		$Sprite.play("Idle")
		$Sprite.rotation = 0
		
	$Sprite.flip_h = false if direction == 1 else true
		
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	motion = move_and_slide(motion, UP)
