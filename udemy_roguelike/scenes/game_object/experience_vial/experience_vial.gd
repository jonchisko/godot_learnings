extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(_on_area_entered)
	
	
func _on_area_entered(other: Area2D) -> void:
	GameEvents.emit_experience_vial_collected(1)
	queue_free()
