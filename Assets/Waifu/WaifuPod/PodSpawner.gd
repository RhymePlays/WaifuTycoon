extends StaticBody

export var podID = "Pod1"
export var cost = 5000
export var place = "GreenPlace"

func spawnPod():
	var waifuPod = get_node("/root/subRoot/"+place).data.waifuPod.instance()
	waifuPod.podID = podID
	waifuPod.place = place
	waifuPod.transform.origin = self.transform.origin
	self.get_parent().add_child(waifuPod)

	self.queue_free()

var interactableByUsersOfXPlace
func interact():
	if get_node("/root/subRoot/"+place).data.money >= cost:
		get_node("/root/subRoot/"+place).data.money = get_node("/root/subRoot/"+place).data.money - cost
		spawnPod()

func _ready():
	interactableByUsersOfXPlace = place
	if podID in get_node("/root/subRoot/"+place).data.pods:
		spawnPod()
	else:
		$Label3D.text = "Unlock Pod\n"+str(cost)+"g"
	
