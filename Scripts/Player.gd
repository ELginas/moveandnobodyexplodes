extends KinematicBody2D

var starting_pos

var isRight = false

const MOVE_SPEED = 400
const JUMP_FORCE = 400
const GRAVITY = 20
const MAX_FALL_SPEED = 400

const AFK_TIME = 1
var current_afk_time = 0
var moved = false

var y_velo = 0

var previous_pos = Vector2()

var bomb

func _ready():
	add_to_group("Player")
	starting_pos = position


func _physics_process(delta):
	if not bomb:
		bomb = get_tree().get_nodes_in_group("Bomb")[0]
	
	var move_dir = 0
	if Input.is_action_pressed("ui_right"):
		move_dir += 1
		if not moved:
			moved = true
	if Input.is_action_pressed("ui_left"):
		move_dir -= 1
		if not moved:
			moved = true
	
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
	
	var grounded = is_on_floor()
	y_velo += GRAVITY
	if grounded and Input.is_action_pressed("ui_up"):
		y_velo = -JUMP_FORCE
		if not moved:
			moved = true
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
	
	if isRight and move_dir < 0:
		flip()
	if !isRight and move_dir > 0:
		flip()
	
	if move_dir == 0 and grounded:
		if moved:
			if previous_pos == position:
				if not (bomb.exploded or bomb.defused or bomb.defusing):
					current_afk_time += delta
					if current_afk_time >= AFK_TIME:
						reset_pos()
	
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
	
	previous_pos = position


func flip():
	if isRight:
		isRight = false
	else:
		isRight = true
	$Sprite.flip_h = !isRight


func reset_pos():
	position = starting_pos
	current_afk_time = 0
	moved = false