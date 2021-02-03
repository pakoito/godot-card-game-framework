class_name DBDeckCardObject
extends HBoxContainer

signal quantity_changed(value)

var quantity: int 
var card_name: String

onready var card_label:= $CardLabel

func _ready() -> void:
	pass

# This is used to prepare the values of this object
func setup(_card_name: String, count: int) -> void:
	set_quantity(count)
	card_name = _card_name
	card_label.text = _card_name

func set_quantity(value) -> void:
	quantity = value
	$CardCount.text = str(value) + 'x'

func _on_Plus_pressed() -> void:
	emit_signal("quantity_changed", quantity + 1)


func _on_Minus_pressed() -> void:
	emit_signal("quantity_changed", quantity - 1)
