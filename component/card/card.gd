class_name Card
extends Control

signal drag_ended(card: Card)

const SCALE_NORMAL = Vector2(1.0, 1.0)
const SCALE_LARGE = Vector2(1.05, 1.05)

var scale_tween: Tween
var hovered = false
var offset: Vector2
var dragging := false
var returning_home := false
var home_position: Vector2

func _ready():
	pivot_offset = size / 2

func _process(delta: float):
	if dragging:
		global_position = get_global_mouse_position() - offset

func _on_gui_input(event: InputEvent) -> void:
	if dragging and event.is_action_released('click'):
		_end_drag()
		return
	if not DragDrop.is_dragging and !returning_home and event.is_action_pressed("click"):
		_start_drag()
			
func _input(event: InputEvent):
	if dragging and event.is_action_released('click'):
		_end_drag()
		get_viewport().set_input_as_handled()
			
func _start_drag():
	home_position = position
	dragging = true
	DragDrop.is_dragging = true
	offset = get_global_mouse_position() - global_position
	
func _end_drag():
	_scale(SCALE_NORMAL)
	dragging = false
	DragDrop.is_dragging = false
	drag_ended.emit(self)
	return_home()
	
func return_home():
	returning_home = true
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, 'position', home_position, 0.2)
	await tween.finished
	returning_home = false

func _on_mouse_entered() -> void:
	if dragging or returning_home:
		return
	if not DragDrop.is_dragging:
		hovered = true
		_scale(SCALE_LARGE)

func _on_mouse_exited() -> void:
	if not dragging:
		hovered = false
		_scale(SCALE_NORMAL)
		
func _scale(new_scale: Vector2):
	if scale_tween:
		scale_tween.kill()
	scale_tween = create_tween()
	scale_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	scale_tween.tween_property(self, 'scale', new_scale, 0.2)
