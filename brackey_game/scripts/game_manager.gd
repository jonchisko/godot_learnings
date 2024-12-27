extends Node

@onready var score_label: Label = $"../Text/ScoreLabel"

var score = 0

func add_point() -> void:
	score += 1
	print(score)
	score_label.text = "You collected " + str(score) + " coins."
