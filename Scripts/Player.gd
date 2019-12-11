extends KinematicBody2D

var starting_pos

var isRight = false

const MOVE_SPEED = 400
const JUMP_FORCE = 400
const GRAVITY = 20
const MAX_FALL_SPEED = 400

var y_velo = 0

func _ready():
	add_to_group("Player")
	starting_pos = position


func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("ui_right"):
		move_dir += 1
	if Input.is_action_pressed("ui_left"):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
	
	var grounded = is_on_floor()
	y_velo += GRAVITY
	if grounded and Input.is_action_pressed("ui_up"):
		y_velo = -JUMP_FORCE
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
	
	if isRight and move_dir < 0:
		flip()
	if !isRight and move_dir > 0:
		flip()
	
	if grounded:
		if move_dir == 0:
			if $WalkingSound.playing:
				$WalkingSound.playing = false
			$Sprite.play("Idle")
		else:
			if not $WalkingSound.playing:
				$WalkingSound.playing = true
			$Sprite.play("Run")
	else:
		if $WalkingSound.playing:
			$WalkingSound.playing = false


func flip():
	if isRight:
		isRight = false
	else:
		isRight = true
	$Sprite.flip_h = !isRight


func reset_pos():
	position = starting_pos