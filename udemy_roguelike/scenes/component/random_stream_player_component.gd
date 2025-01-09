extends AudioStreamPlayer

@export var streams: Array[AudioStream]

@export var randomize_pitch = true
@export var min_pitch = .9
@export var max_pitch = 1.1

func play_random():
	if self.streams == null or self.streams.size() == 0:
		return	
	self.stream = self.streams.pick_random()
	
	if self.randomize_pitch:
		self.pitch_scale = randf_range(self.min_pitch, self.max_pitch)
	else:
		self.pitch_scale = 1
	self.play()
