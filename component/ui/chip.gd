class_name Chip
extends PanelContainer

@onready var label = $MarginContainer/Label

func _ready():
	add_theme_stylebox_override('panel', get_theme_stylebox('panel').duplicate())
	label.text = text
	_apply_color()

var text: String:
	set(new_value):
		text = new_value
		label.text = new_value
		
var color: Color:
	set(new_value):
		color = new_value
		_apply_color()

func _apply_color():
	if not is_node_ready():
		return
	var style := get_theme_stylebox('panel') as StyleBoxFlat
	style.bg_color = color
	label.add_theme_color_override('font_color', Color.BLACK if color.get_luminance() > 0.5 else Color.WHITE)
