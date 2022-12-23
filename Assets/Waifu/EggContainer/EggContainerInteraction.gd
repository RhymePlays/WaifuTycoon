extends StaticBody

onready var worldDataNode = get_node("/root/subRoot/")

var interactableByUsersOfXPlace
func interact():
	worldDataNode.data.places[get_parent().get_parent().placeID].money = worldDataNode.data.places[get_parent().get_parent().placeID].money + worldDataNode.data.waifus[get_parent().get_parent().current_waifu].EggPrice * worldDataNode.data.places[get_parent().get_parent().placeID].pods[get_parent().get_parent().podID].EggCount
	get_node("/root/subRoot/UI").updateMoney()
	
	worldDataNode.data.places[get_parent().get_parent().placeID].pods[get_parent().get_parent().podID].EggCount = 0
	get_parent().get_parent().updateCounter()

func _ready():
	interactableByUsersOfXPlace = get_parent().get_parent().placeID