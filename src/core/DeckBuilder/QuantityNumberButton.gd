class_name QuantityNumberButton
extends Button

var quantity_number: int
signal quantity_set(value)

func _ready() -> void:
	quantity_number = int(name)
	connect("pressed",self,"_on_button_pressed")


func _on_button_pressed() -> void:
	emit_signal("quantity_set",quantity_number)
