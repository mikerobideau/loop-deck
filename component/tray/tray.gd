class_name Tray
extends StaticBody2D

const HIGHLIGHT_COLOR = Color(Color.REBECCA_PURPLE, 1)
const NORMAL_COLOR = Color(Color.MEDIUM_PURPLE, 0.7)

func _ready():
	modulate = NORMAL_COLOR
	
func _process(delta):
	#visible = DragDrop.is_dragging
	visible = true

func highlight():
	modulate = HIGHLIGHT_COLOR
	
func unhighlight():
	modulate = NORMAL_COLOR
