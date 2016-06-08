	
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	var curPos = Vector2(self.get_parent().get_rect().size.width/2, self.get_parent().get_rect().size.height/2)
	self.set_pos(curPos)


