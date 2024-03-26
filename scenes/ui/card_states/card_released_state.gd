extends CardState

var played: bool

func enter() -> void:
	played = false
	if not card_ui.targets.is_empty():
		Events.tooltip_hide_requested.emit()
		played = true
		card_ui.play()

# write input function to fully go through enter function to transition to released state properly

func on_input(_event: InputEvent) -> void:
	# played in the target area correctly
	if played:
		return
	
	# if not, return back to base
	transition_requested.emit(self, CardState.State.BASE)
