extends Label

const CHECKMARK = preload("res://Scenes/Checkmark.tscn")

const DEFUSED_COLOR = Color8(71, 232, 71)

export(int) var bomb_seconds = 90

var current_seconds
var previous_seconds = 0

var defused

var min_time
var sec_time

var counted = false

func _ready():
	add_to_group("GameScript")
	current_seconds = bomb_seconds
	update_time()


func _process(delta):
	if not defused:
		current_seconds -= delta
		update_time()


func update_time():
	if not counted:
		min_time = 0
		sec_time = current_seconds
		while sec_time >= 60:
			min_time += 1
			sec_time -= 60
		
		if previous_seconds != 0:
			if floor(previous_seconds) > floor(current_seconds):
				$BeepSound.play()
		
		if current_seconds <= 0:
			explode()
			return
		
		var sec_text
		if min_time <= 0:
			if sec_time > 5:
				if sec_time < 10:
					sec_text = "0"+str(int(sec_time))
				else:
					sec_text = str(int(sec_time))
			else:
				sec_text = "0"+"%3.2f" % sec_time
		else:
			if sec_time < 10:
				sec_text = "0"+str(int(sec_time))
			else:
				sec_text = "%2.0f" % sec_time
		var texty = str(min_time)+":"+sec_text
		text = texty
		get_tree().get_nodes_in_group("Bomb")[0].set_text(texty)
		previous_seconds = current_seconds


func defused():
	defused = true
	get_tree().get_nodes_in_group("Bomb")[0].set_text_color(DEFUSED_COLOR)
	add_color_override("font_color", DEFUSED_COLOR)
	
	var checkmark = CHECKMARK.instance()
	checkmark.play_anim()
	get_parent().get_parent().add_child(checkmark)


func explode():
	var bomb = get_tree().get_nodes_in_group("Bomb")[0]
	var camera = get_tree().get_nodes_in_group("Camera")[0]
	counted = true
	var texty = "0:00"
	text = texty
	bomb.set_text(texty)
	bomb.explode()
	camera.shake(1, 20, 20)