extends CardState


func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready
	
	if card_ui.tween and card_ui.tween.is_running():
		card_ui.tween.kill()

	# visual interface of base state
	card_ui.background.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	card_ui.reparent_requested.emit(card_ui)
	card_ui.pivot_offset = Vector2.ZERO
	Events.tooltip_hide_requested.emit()

func on_gui_input(event: InputEvent) -> void:
	if not card_ui.playable or card_ui.disabled:
		return

	# left click on the card ui node turns state into click
	if event.is_action_pressed("left_mouse"):
		# position of the card is determined by mouse pointer movement, this becomes holding the card with the pointer
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)
	
func on_mouse_entered() -> void:
	if not card_ui.playable or card_ui.disabled:
		return
	# visual interface of hover state
	card_ui.background.set("theme_override_styles/panel", card_ui.HOVER_STYLEBOX)
	Events.card_tooltip_requested.emit(card_ui.card.icon, card_ui.card.tooltip_text)

func on_mouse_exited() -> void:
	if not card_ui.playable or card_ui.disabled:
		return
	# visual interface of base state
	card_ui.background.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	Events.tooltip_hide_requested.emit()
