extends Control

func updateMoney():
	get_node("/root/subRoot/UI/MoneyCounter").text = " Money: "+str(get_node("/root/subRoot").data.places[get_node("/root/subRoot/SelfPlayer").userOfXPlace].money)+"g"

func _ready():
	updateMoney()
