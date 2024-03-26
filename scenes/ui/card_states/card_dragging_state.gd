extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.05

var minimum_drag_time_elapsed := false


func enter() -> void:
	# this code selects the first node of ui tree, meaning we can set the parent node even if the hierarchy changes
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
	
	card_ui.background.set("theme_override_styles/panel", card_ui.DRAG_STYLEBOX)
	Events.card_drag_started.emit(card_ui)

	# dragging should continue at least 0.05s in order to fully enter dragging state
	minimum_drag_time_elapsed = false
	var threshhold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshhold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)
	

func exit() -> void:
	Events.card_drag_ended.emit(card_ui)


func on_input(event: InputEvent) -> void:
	var single_targeted := card_ui.card.is_single_targeted()
	# mouse movement determines if the user is using card or canceling card
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")

	if single_targeted and mouse_motion and card_ui.targets.size() > 0:
		transition_requested.emit(self, CardState.State.AIMING)
		return

	if mouse_motion:
		# sticks to the cursor
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset

	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and confirm:
		# can't input subsequent mouse activities()
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)

	



