class_name DBCardObject
extends HBoxContainer

signal quantity_changed(value)

var quantity: int setget set_quantity
var card_properties: Dictionary
var card_name: String

func _ready() -> void:
	pass



# Setter for quantity
#
# Will also set the correct button as pressed
func set_quantity(value) -> void:
	quantity = value
	emit_signal("quantity_changed", value)
