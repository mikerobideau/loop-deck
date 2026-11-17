class_name Main
extends Control

var HomeScene = preload("res://screen/home_screen/home_screen.tscn")
var GameScene = preload("res://screen/game_screen/game_screen.tscn")

@onready var active_screen = $ActiveScreen

func _ready():
	var home = HomeScene.instantiate()
	_set_screen(home)
	home.new_game_clicked.connect(_on_new_game)
	
func _on_new_game():
	_clear_screen()
	var game = GameScene.instantiate()
	_set_screen(game)
	
func _set_screen(node: Node):
	active_screen.add_child(node)
	
func _clear_screen():
	for child in active_screen.get_children():
		active_screen.remove_child(child)
