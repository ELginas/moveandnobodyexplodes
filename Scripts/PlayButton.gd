extends TextureButton

# Getting back to starting position
const SMOOTH_SPEED = 2
var repos = Vector2()
var repos_velo = Vector2()
var position = Vector2()

var starting_pos

var mouse_entered

func _ready():
	starting_pos = rect_position


func _on_PlayButton_mouse_entered():
	mouse_entered = true
	move()


func _on_PlayButton_mouse_exited():
	mouse_entered = false


func move():
	var mouse_position = get_global_mouse_position()
	var new_position = rect_position
	var direction = (get_true_pos(new_position) - mouse_position).normalized()
	while is_in_area(new_position, mouse_position, 5):
		new_position += direction
	rect_position = new_position


func get_true_pos(position):
	return Vector2(position.x + rect_size.x / 2, position.y + rect_size.y / 2)


func is_in_area(self_pos, target_position, radius):
	if self_pos.x - radius < target_position.x and target_position.x < self_pos.x + rect_size.x + radius : # Is in X axis
		if self_pos.y - radius < target_position.y and target_position.y < self_pos.y + rect_size.y + radius: # Is in Y axis
			return true
	return false


func get_back(delta):
	var mpos = starting_pos
	var destination = rect_position
	
	if mpos != destination:
		repos.x = mpos.x - destination.x
		repos.y = mpos.y - destination.y
		repos_velo.x = repos.x * SMOOTH_SPEED * delta
		repos_velo.y = repos.y * SMOOTH_SPEED * delta
		
		position.x += repos_velo.x
		position.y += repos_velo.y
		
		rect_position += repos_velo


func _process(delta):
	if mouse_entered:
		move()
	#elif not is_in_area(rect_position, get_global_mouse_position(), 100):
	#	get_back(delta)