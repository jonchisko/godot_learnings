extends Node


signal arena_difficulty_increased(arena_difficulty: int)


const DIFFICULTY_INTERVAL = 5


@export var end_screen_scene: PackedScene
@onready var timer: Timer = $Timer

var arena_difficulty = 0
var previous_time = 0


func _ready():
	self.previous_time = self.timer.wait_time


func get_time_elapsed():
	return timer.wait_time - timer.time_left


func _process(delta):
	var next_time_target = self.timer.wait_time - (self.arena_difficulty + 1) * self.DIFFICULTY_INTERVAL
	if self.timer.time_left <= next_time_target:
		self.arena_difficulty += 1
		self.arena_difficulty_increased.emit(self.arena_difficulty)
		print("Arena difficulty change: " + str(self.arena_difficulty))


func _on_timer_timeout():
	var end_screen_instance = self.end_screen_scene.instantiate()
	self.add_child(end_screen_instance)
	end_screen_instance.set_victory()
	MetaProgression.save()
