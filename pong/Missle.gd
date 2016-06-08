
extends KinematicBody2D

const MISSLE_SPEED = 0.1

var root = null

var missle_pos = self.get_pos()
var direction

func _ready():
	root = get_tree().get_root().get_node("Node2DGame")
	set_process(true)
	pass

func _process(delta):
	move(Vector2(MISSLE_SPEED,0))
	

