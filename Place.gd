extends Spatial

var placeName = "GreenWorld"

var data = {
	"money": 0,
	"waifuPod": preload("res://Assets/Waifu/WaifuPod/WaifuPod.tscn"),
	"waifus": {
		"NoWaifuSelected": {"VideoURL": "res://Assets/Waifu/NoWaifuSelected/NoWaifuSelected.webm", "EggPrice": 0, "PerFragment": 0, "EggScene": preload("res://Assets/Waifu/NoWaifuSelected/BlankEgg.escn"), "ActiveColor": Color.white},
		"Rem": {"VideoURL": "res://Assets/Waifu/Rem/Rem.webm", "EggPrice": 10, "PerFragment": 0.1, "EggScene": preload("res://Assets/Waifu/Rem/RemEgg.tscn"), "ActiveColor": Color.blue},
	},
	"unlockedWaifus": ["NoWaifuSelected", "Rem"],
	"pods": {}
}

func updateMoney():
	get_node("/root/subRoot/UI/MoneyCounter").text = " Money: "+str(data.money)+"g"

func updatePrices(): #Move the Price Updater from here to someplace else
	var pricesString = ""
	var itemNumber = 0
	for waifu in data.waifus:
		itemNumber = itemNumber + 1
		pricesString = pricesString + "\n  "+str(itemNumber)+") "+waifu+" Eggs - "+str(data.waifus[waifu].EggPrice)+":"+str(data.waifus[waifu].PerFragment)
	
	get_node("/root/subRoot/GreenPlace/Building/Monitor/Label3D").text = "Prices:"+pricesString

func _ready():
	# Cursor Lock
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Board Price Updater
	self.updatePrices()
	updateMoney()