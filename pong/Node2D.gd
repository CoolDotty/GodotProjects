extends Node2D

var screen_size
var pad_size

var packedMissle = load("res://Missle.scn") # will load when the script is instanced

func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("Left Paddle").get_texture().get_size()
	set_process(true)
	set_process_input(true)
	print("ready")

#speed of the ball (in pixels/second)
var ball_speed = 300

#direction of the ball (normal vector)
var direction = Vector2(-1, 0)

#constant for pad speed (also in pixels/second)
const PAD_SPEED = 300
const BALL_SPEED = 300

func processBall(delta):
	var ball_pos = get_node("Ball").get_pos()
	var left_rect = Rect2( get_node("Left Paddle").get_pos() - pad_size/2, pad_size )
	var right_rect = Rect2( get_node("Right Paddle").get_pos() - pad_size/2, pad_size )
	ball_pos += direction * ball_speed * delta
	if ( (ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
    	direction.y = -direction.y
	if ( (left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
    	direction.x = -direction.x
    	ball_speed *= 1.1
    	direction.y = randf() * 2.0 - 1
    	direction = direction.normalized()
	if (ball_pos.x < 0 or ball_pos.x > screen_size.x):
    	ball_pos = screen_size * 0.5  # ball goes to screen center
    	ball_speed = BALL_SPEED

    	direction = Vector2(-1, 0)
	get_node("Ball").set_pos(ball_pos)

func processPlayers(delta):
	#move left pad
	var left_pos = get_node("Left Paddle").get_pos()
	
	if (left_pos.y > 0 and Input.is_action_pressed("P1MoveUp")):
	    left_pos.y += -PAD_SPEED * delta
	if (left_pos.y < screen_size.y and Input.is_action_pressed("P1MoveDown")):
	    left_pos.y += PAD_SPEED * delta
	
	get_node("Left Paddle").set_pos(left_pos)
	
	#move right pad
	var right_pos = get_node("Right Paddle").get_pos()
	
	if (right_pos.y > 0 and Input.is_action_pressed("P2MoveUp")):
	    right_pos.y += -PAD_SPEED * delta
	if (right_pos.y < screen_size.y and Input.is_action_pressed("P2MoveDown")):
	    right_pos.y += PAD_SPEED * delta
	
	get_node("Right Paddle").set_pos(right_pos)

func _process(delta):
	processBall(delta)
	processPlayers(delta)
	
func _input(event):
	if(event.is_action_pressed("P1Shoot")):
		if(!event.is_echo()):
			var missle = packedMissle.instance() # create a new sprite!
			missle.set_pos(get_node("Left Paddle").get_pos())
			var newPos = missle.get_pos()
			newPos.x += 25
			missle.set_pos(newPos)
			missle.direction = Vector2(1, 0)
			missle.set_rot(3.14)
			add_child(missle) # add it as a child of this node
	
	if(event.is_action_pressed("P2Shoot")):
		if(!event.is_echo()):
			var missle = packedMissle.instance() # create a new sprite!
			missle.set_pos(get_node("Right Paddle").get_pos())
			var newPos = missle.get_pos()
			newPos.x -= 25
			missle.set_pos(newPos)
			missle.direction = Vector2(-1, 0)
			missle.set_rot(0)
			add_child(missle) # add it as a child of this node