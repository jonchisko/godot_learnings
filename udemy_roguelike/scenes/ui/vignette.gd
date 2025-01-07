extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.player_damaged.connect(self._on_player_damaged)


func _on_player_damaged():
	$AnimationPlayer.play("hit")
