extends StaticBody

export var podID = "Pod1"
export var cost = 5000

func spawnPod():
	var waifuPod = get_node("/root/subRoot/GreenPlace").data.waifuPod.instance()
	waifuPod.podID = podID
	waifuPod.transform.origin = self.transform.origin
	self.get_parent().add_child(waifuPod)

	self.queue_free()

func _ready():
	if podID in get_node("/root/subRoot/GreenPlace").data.pods:
		spawnPod()
	else:
		$Label3D.text = "Unlock Pod\n"+str(cost)+"g"

func interact():
	if get_node("/root/subRoot/GreenPlace").data.money >= cost:
		get_node("/root/subRoot/GreenPlace").data.money = get_node("/root/subRoot/GreenPlace").data.money - cost
		spawnPod()
