extends CanvasLayer

@onready var end_screen_title = %EndScreenTitle
@onready var end_screen_description = %EndScreenDescription


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true


func set_defeat():
	self.end_screen_title.text = "Defeat"
	self.end_screen_description.text = "You lost!"
	

func set_victory():
	self.end_screen_title.text = "Victory"
	self.end_screen_description.text = "You won!"


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://udemy_roguelike/scenes/main/main.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
