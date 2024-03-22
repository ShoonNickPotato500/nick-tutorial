class_name CardPile
extends Resource

signal card_pile_size_changed(cards_amount)

@export var cards: Array[Card] = []


func empty() -> bool:
	return cards.is_empty()

func draw_card() -> Card:
	if empty():
		return null
	var card = cards.pop_front()
	emit_signal("card_pile_size_changed", cards.size())
	return card


func add_card(card: Card) -> void:
	cards.append(card)
	emit_signal("card_pile_size_changed", cards.size())


func shuffle() -> void:
	cards.shuffle()

func clear() -> void:
	cards.clear()
	emit_signal("card_pile_size_changed", cards.size())

func _to_string() -> String:
	var _card_strings: PackedStringArray = []
	for i in range(cards.size()):
		_card_strings.append("%s: %s" % [i+1, cards[i].id])
	return "\n".join(_card_strings)

