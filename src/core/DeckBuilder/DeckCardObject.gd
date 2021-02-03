class_name DBDeckCardObject
extends HBoxContainer

var quantity: int 
signal quantity_changed(value)

onready var card_label:= $CardLabel

func _ready() -> void:
	pass

# This is used to prepare the values of this object
func setup(card_name: String, count: int) -> void:
	set_quantity(count)
	set_card_label(card_name)

func set_quantity(value) -> void:
	quantity = value
	$CardCount.text = str(value) + 'x'

func set_card_label(card_name) -> void:
	card_label.text = card_name


func _on_Plus_pressed() -> void:
	emit_signal("quantity_changed", quantity + 1)


func _on_Minus_pressed() -> void:
	emit_signal("quantity_changed", quantity - 1)
