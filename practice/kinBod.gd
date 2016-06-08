
extends KinematicBody2D

const speed = 100

func _ready():
	set_fixed_process(true)
	get_node("../Area2D").connect("body_enter", self, "_on_area2D_body_enter")
	get_node("../Area2D").connect("body_exit", self, "_on_area2D_body_exit")

func _fixed_process(delta):
	var direction = Vector2(0, 0)
	if ( Input.is_action_pressed("ui_up") ):
		direction += Vector2(0,-1)
	if ( Input.is_action_pressed("ui_down") ):
		direction += Vector2(0,1)
	if ( Input.is_action_pressed("ui_left") ):
		direction += Vector2(-1,0)
	if ( Input.is_action_pressed("ui_right") ):
		direction += Vector2(1,0)
		
	if is_colliding():
		var n = get_collision_normal()
		direction = n.slide(direction)
		move(direction * speed * delta)
	
	move(direction * speed * delta)
	
func _on_area2D_body_enter(body):
	print("in doot")

func _on_area2D_body_exit(body):
	print("out doot")
