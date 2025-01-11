extends CanvasLayer

signal transition_halfway

var skip_emit = false

func transition():
	$AnimationPlayer.play("default")
	await self.transition_halfway
	self.skip_emit = true
	$AnimationPlayer.play_backwards("default")

func emit_transition_halfway():
	if self.skip_emit:
		self.skip_emit = false
		return 
	self.transition_halfway.emit()
