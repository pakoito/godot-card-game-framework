class_name DBListCardObject
extends HBoxContainer

var deck_card_object: DBDeckCardObject
var deckbuilder
# The max quantity allowed for this particular card
var max_allowed: int

var quantity: int setget set_quantity
var card_properties: Dictionary
var card_name: String
# We will look for this card property to determine how many possible
# copies of the card are allowed in the deck. A value of 0 (or undefined)
# Will allow as many copies as the max_quantity
export var quantity_property: String = "_max_allowed"


onready var card_label:= $CardLabel
onready var plus_button := $Quantity/Plus
onready var minus_button := $Quantity/Minus
onready var quantity_edit := $Quantity/IntegerLineEdit
onready var qbuttons = {
	0: $'Quantity/0',
	1: $'Quantity/1',
	2: $'Quantity/2',
	3: $'Quantity/3',
	4: $'Quantity/4',
	5: $'Quantity/5',
}

func _ready() -> void:
	for quantity_button in qbuttons:
		qbuttons[quantity_button].connect("quantity_set", self, "_on_quantity_set")
	quantity_edit.minimum = 0
	quantity_edit.connect("int_entered", self, "set_quantity")
# Setter for quantity
#
# Will also set the correct button as pressed
func set_quantity(value) -> void:
	if value < 0:
		value = 0
	quantity = value
	if value > max_allowed:
		return
	for button in qbuttons:
		if button == value:
			qbuttons[button].pressed = true
		else:
			qbuttons[button].pressed = false
	if value:
		quantity_edit.text = str(value)
	else:
		quantity_edit.text = ''
	if value > 0:
		if not deck_card_object:
			deck_card_object = deckbuilder.add_new_card(
					card_name, 
					card_properties[CardConfig.SCENE_PROPERTY], 
					value)	
			deck_card_object.connect("quantity_changed",self,"_on_quantity_set")
		else:
			deck_card_object.set_quantity(value)
	elif value == 0:
		if deck_card_object:
			deck_card_object.queue_free()
			deck_card_object = null


# This is used to prepare the values of this object
func setup(_card_name: String, count = 0) -> void:
	card_properties = cfc.card_definitions[_card_name].duplicate()
	card_name = _card_name
	$Type.text = card_properties[CardConfig.SCENE_PROPERTY]
	card_label.text = card_name
	setup_max_quantity()
	set_quantity(count)


func setup_max_quantity() -> void:
	if card_properties.get("_max_allowed",0):
		 max_allowed = card_properties.get("_max_allowed")
	quantity_edit.maximum = max_allowed
	quantity_edit.placeholder_text = \
			"Max " + str(max_allowed)
	if max_allowed <= 5:
		for iter in range(1,max_allowed+1):
			qbuttons[iter].visible = true
	else:
		plus_button.visible = true
		minus_button.visible = true
		quantity_edit.visible = true

func _on_quantity_set(value: int) -> void:
	set_quantity(value)

func _on_Plus_pressed() -> void:
	set_quantity(quantity + 1)

func _on_Minus_pressed() -> void:
	set_quantity(quantity - 1)
