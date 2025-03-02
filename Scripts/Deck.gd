extends Node2D

const CARD_SCENE_PATH = "res://Scenes/Card.tscn"
const CARD_DRAW_SPEED = 0.2

var player_deck = ["Al", "Be", "Br", "Ca", "C", "F", "I", "K", "Li", "Mg", "Na", "N", "O"]
var card_database_reference


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_deck.shuffle()
	$RichTextLabel.text = str(player_deck.size())
	card_database_reference = preload("res://Scripts/CardDatabase.gd")
	
	
func draw_card():
	
	if $"../PlayerHand".player_hand.size() >= 6:
		return 
	
	
	var card_drawn_name = player_deck[0]
	player_deck.erase(card_drawn_name)

	# If player drew the last card in the deck, disable the deck
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
		$RichTextLabel.visible = false

	$RichTextLabel.text = str(player_deck.size())
	
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	var card_image_path = str("res://Elementalist Game Assets/Cards/" + card_drawn_name + "Card.png")
	new_card.get_node("CardImage").texture = load(card_image_path)
	new_card.get_node("AtomicNumber").text = str(card_database_reference.CARDS[card_drawn_name][0])
	new_card.get_node("ValenceElectrons").text = str(card_database_reference.CARDS[card_drawn_name][1])
	new_card.get_node("Electronegativity").text = str(card_database_reference.CARDS[card_drawn_name][2])
	$"../CardManager".add_child(new_card)
	new_card.name = "Card"
	$"../PlayerHand".add_card_to_hand(new_card, CARD_DRAW_SPEED)
