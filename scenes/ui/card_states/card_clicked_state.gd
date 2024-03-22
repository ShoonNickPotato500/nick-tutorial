extends CardState


func enter() -> void:
	# when entering this state, start monitoring drop point to check drop area
	card_ui.drop_point_detector.monitoring = true

func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING)
	
