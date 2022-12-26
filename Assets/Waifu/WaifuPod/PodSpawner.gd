extends StaticBody

export var podID = "Pod1"
export var cost = 5000
export var placeID = "GreenPlace"

func spawnPod():
	var waifuPod = get_node("/root/subRoot/").data.miscPreloads.waifuPod.instance()
	waifuPod.podID = podID
	waifuPod.placeID = placeID
	waifuPod.transform.origin = self.transform.origin
	self.get_parent().add_child(waifuPod)

	self.queue_free()

var interactableByUsersOfXPlace
func interact():
	if get_node("/root/subRoot/").data.places[placeID].money >= cost:
		get_node("/root/subRoot/").data.places[placeID].money = get_node("/root/subRoot/").data.places[placeID].money - cost
		spawnPod()

func _ready():
	interactableByUsersOfXPlace = placeID
	if podID in get_node("/root/subRoot/").data.places[placeID].pods:
		spawnPod()
	else:
		$Label3D.text = "Unlock Pod\n"+str(cost)+"g"
	
