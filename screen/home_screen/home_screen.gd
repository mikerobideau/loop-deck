class_name HomeScreen
extends Control

signal new_game_clicked()

func _on_play_button_pressed() -> void:
	new_game_clicked.emit()
