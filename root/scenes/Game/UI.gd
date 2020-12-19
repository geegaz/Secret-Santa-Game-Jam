extends Control

var max_charges: int
var charges_left: int
var charges = []
var charge_scene = preload("res://scenes/Game/Charge.tscn")

onready var _Charges = $VBoxContainer/Charges

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setup_charges(amount):
	max_charges = amount
	var temp_charge
	for i in range(amount):
		temp_charge = charge_scene.instance()
		_Charges.add_child(temp_charge)
		charges.append(temp_charge)
	
	reload_charges()

func use_charge():
	if charges_left > 0 and charges_left-1 <= charges.size():
		charges[charges_left-1].value = 0
		charges_left -= 1

func reload_charges():
	charges_left = max_charges
	for charge in charges:
		charge.value = 1
	
