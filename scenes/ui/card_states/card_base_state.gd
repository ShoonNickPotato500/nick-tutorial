extends CardState


func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready
	
	# visual interface of base state
	card_ui.reparent_requested.emit(card_ui)
	card_ui.color.color = Color.WEB_GREEN
	card_ui.state.text = "BASE"
	card_ui.pivot_offset = Vector2.ZERO

func on_gui_input(event: InputEvent) -> void:
	# left click on the card ui node turns state into click
	if event.is_action_pressed("left_mouse"):
		# position of the card is determined by mouse pointer movement, this becomes holding the card with the pointer
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)
	

