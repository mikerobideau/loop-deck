class_name Card
extends Control

signal clicked(card: Card)
signal drag_started(card: Card)
signal drag_ended(card: Card)

const FOCUS_COLOR = Color.WHITE
const SELECTED_COLOR = Color.AQUA
const DRAG_THRESHOLD := 8.0
const SCALE_NORMAL = Vector2(1.0, 1.0)
const SCALE_LARGE = Vector2(1.05, 1.05)
const Z_RAISED = 10

static var any_dragging := false

var scale_tween: Tween
var hovered = false
var offset: Vector2
var dragging := false
var moving := false
var home_position: Vector2
var drop_accepted := false
var pressing := false
var press_global : Vector2
var selected := false

func _ready():
	pivot_offset = size / 2

func _process(delta: float):
	if pressing and not dragging and get_global_mouse_position().distance_to(press_global) > DRAG_THRESHOLD:
		pressing = false
		_start_drag()
	if dragging:
		global_position = get_global_mouse_position() - offset
		
func _draw():
	if has_focus():
		draw_rect(Rect2(Vector2(-4, -4), size + Vector2(8,8)), FOCUS_COLOR, false, 5.0)
	if selected:
		draw_rect(Rect2(Vector2(-4, -4), size + Vector2(8,8)), SELECTED_COLOR, false, 5.0)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed('click') and not Card.any_dragging and !moving:
		pressing = true
		press_global = get_global_mouse_position()
		offset = press_global - global_position
		_update_z()
	elif event.is_action_pressed('ui_accept') or event.is_action_pressed('select'):
		clicked.emit(self)
			
func _input(event: InputEvent):
	if event.is_action_released('click'):
		if dragging:
			_end_drag()
			get_viewport().set_input_as_handled()
		elif pressing:
			pressing = false
			clicked.emit(self)
			_update_z()

func set_selected(on: bool):
	selected = on
	_update_z()
	queue_redraw()
	
func _start_drag():
	pressing = false
	dragging = true
	Card.any_dragging = true
	_update_z()
	home_position = position
	drag_started.emit(self)
	
func _end_drag():
	pressing = false
	_scale(SCALE_NORMAL)
	_update_z()
	dragging = false
	Card.any_dragging = false
	drag_ended.emit(self)
	
func accept_drop():
	drop_accepted = true
	home_position = Vector2.ZERO
	_slide_to(Vector2.ZERO)
	
func _slide_to(to_pos: Vector2):
	moving = true
	_update_z()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, 'position', to_pos, 0.2)
	await tween.finished
	moving = false
	_update_z()
	
func return_home():
	_slide_to(home_position)

func _on_mouse_entered() -> void:
	if dragging or moving:
		return
	if not Card.any_dragging:
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
	
func _update_z():
	z_index = Z_RAISED if (pressing or dragging or moving or selected) else 0
