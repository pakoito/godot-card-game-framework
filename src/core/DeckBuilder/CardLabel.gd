class_name CardLabel
extends Label

var preview_card: Card
onready var preview_popup:= $PreviewPopup

func _ready() -> void:
	text = "Test Card 1" # debug

func _process(_delta: float) -> void:
	if preview_popup.visible:
		preview_popup.rect_position = get_global_mouse_position() + Vector2(10,0)

func setup(card_name) -> void:
	text = card_name

func _on_CardLabel_mouse_entered() -> void:
	preview_card = cfc.instance_card(text)
	preview_popup.add_child(preview_card)
	preview_popup.rect_position = get_global_mouse_position() + Vector2(10,0)
	preview_popup.mouse_filter = Control.MOUSE_FILTER_IGNORE
	preview_popup.visible = true


func _on_CardLabel_mouse_exited() -> void:
	preview_card.queue_free()
	preview_popup.visible = false
