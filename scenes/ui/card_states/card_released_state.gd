extends CardState

var played: bool

func enter() -> void:
	card_ui.color.color = Color.PURPLE
	card_ui.state.text = "RELEASED"
	
	played = false
	
	if not card_ui.targets.is_empty():
		played = true
		print("play card for target(s)", card_ui.targets)

# write input function to fully go through enter function to transition to released state properly

func on_input(_event: InputEvent) -> void:
	# played in the target area correctly
	if played:
		return
	
	# if not, return back to base
	transition_requested.emit(self, CardState.State.BASE)
