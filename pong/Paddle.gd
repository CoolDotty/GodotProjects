
extends Sprite

func _on_StaticBody2D_body_enter( body ):
	print(str("Collision: ", body))
	self.set_pos(Vector2(-100, -100))
