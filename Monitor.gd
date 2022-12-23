extends MeshInstance

func updatePrices(): #(Make it into a signal perhaps?)
	var pricesString = ""
	var itemNumber = 0
	for waifu in get_node("/root/subRoot/").data.waifus:
		itemNumber = itemNumber + 1
		pricesString = pricesString + "\n  "+str(itemNumber)+") "+waifu+" Eggs - "+str(get_node("/root/subRoot/").data.waifus[waifu].EggPrice)+":"+str(get_node("/root/subRoot/").data.waifus[waifu].PerFragment)
	$Label3D.text = "Prices:"+pricesString

func _ready():
	updatePrices()