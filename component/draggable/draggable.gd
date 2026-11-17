class_name Draggable
extends Node2D

const SCALE_NORMAL = Vector2(1.0, 1.0)
const SCALE_LARGE = Vector2(1.05, 1.05)

var draggable = false
var is_inside_dropable = false
var body_ref: StaticBody2D
var offset: Vector2
var initial_pos: Vector2

func _ready():
	draggable = true

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed('click'):
			print_debug('click')
			initial_pos = global_position
			offset = get_global_mouse_position() - global_position
			DragDrop.is_dragging = true
		
		if Input.is_action_pressed('click'):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released('click'):
			DragDrop.is_dragging = false
			var tween = create_tween()
			if is_inside_dropable:
				tween.tween_property(self, 'position', body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, 'position', initial_pos, 0.2).set_ease(Tween.EASE_OUT)
				
func _on_area_2d_mouse_entered() -> void:
	if not DragDrop.is_dragging:
		draggable = true
		scale = SCALE_LARGE

func _on_area_2d_mouse_exited() -> void:
	if not DragDrop.is_dragging:
		draggable = false
		scale = SCALE_NORMAL

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body.highlight()
		body_ref = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		body.unhighlight()
