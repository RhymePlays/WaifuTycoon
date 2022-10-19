extends StaticBody

var interactableByUsersOfXPlace
func interact():
	get_parent().get_parent().placeNode.data.money = get_parent().get_parent().placeNode.data.money + get_parent().get_parent().placeNode.data.waifus[get_parent().get_parent().current_waifu].EggPrice * get_parent().get_parent().placeNode.data.pods[get_parent().get_parent().podID].EggCount
	get_parent().get_parent().placeNode.updateMoney()
	
	get_parent().get_parent().placeNode.data.pods[get_parent().get_parent().podID].EggCount = 0
	get_parent().get_parent().updateCounter()

func _ready():
	interactableByUsersOfXPlace = get_parent().get_parent().place