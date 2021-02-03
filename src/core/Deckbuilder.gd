extends PanelContainer

# The maximum amount of each card allowed in a deck.
export var max_quantity: int = 3
# The path to the ListCardObject scene. This has to be defined explicitly
# here, in order to use it in its preload, otherwise the parser gives an error
const _LIST_CARD_OBJECT_SCENE_FILE = CFConst.PATH_CORE\
		+ "/Deckbuilder/ListCardObject.tscn"
const _LIST_CARD_OBJECT_SCENE = preload(_LIST_CARD_OBJECT_SCENE_FILE)
const _DECK_CARD_OBJECT_SCENE_FILE = CFConst.PATH_CORE\
		+ "/Deckbuilder/DeckCardObject.tscn"
const _DECK_CARD_OBJECT_SCENE = preload(_DECK_CARD_OBJECT_SCENE_FILE)
const _DECK_CATEGORY_SCENE_FILE = CFConst.PATH_CORE\
		+ "/Deckbuilder/CategoryContainer.tscn"
const _DECK_CATEGORY_SCENE = preload(_DECK_CATEGORY_SCENE_FILE)

onready var available_cards = $VBC/HBC/MC2/AvailableCards
onready var deck_cards = $VBC/HBC/MC/CurrentDeck/CardsInDeck

func _ready() -> void:
	populate_available_cards()

func populate_available_cards() -> void:
	for card_def in cfc.card_definitions:
		var list_card_object = _LIST_CARD_OBJECT_SCENE.instance()
		available_cards.add_child(list_card_object)
		list_card_object.max_allowed = max_quantity
		list_card_object.deckbuilder = self
		list_card_object.setup(card_def)

func add_new_card(card_name, category, value) -> DBDeckCardObject:
	var category_container
	if not deck_cards.has_node(category):
		category_container = _DECK_CATEGORY_SCENE.instance()
		category_container.name = category
		deck_cards.add_child(category_container)
		category_container.get_node("CategoryLabel").text = category
	else:
		category_container = deck_cards.get_node(category)
	var category_cards_node = category_container.get_node("CategoryCards")
	var deck_card_object = _DECK_CARD_OBJECT_SCENE.instance()
	category_cards_node.add_child(deck_card_object)
	deck_card_object.setup(card_name, value)
	return(deck_card_object)
	
