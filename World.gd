extends Spatial

var data = {
	"money": 0,
	"eggContainer": preload("res://Assets/Waifu/EggContainer/EggContainer.tscn"),
	"waifus": {
		"NoWaifuSelected": {"VideoURL": "res://Assets/Waifu/NoWaifuSelected/NoWaifuSelected.webm", "EggPrice": 0, "PerFragment": 0, "EggScene": preload("res://Assets/Waifu/NoWaifuSelected/BlankEgg.escn"), "ActiveColor": Color.white},
		"Rem": {"VideoURL": "res://Assets/Waifu/Rem/Rem.webm", "EggPrice": 10, "PerFragment": 0.1, "EggScene": preload("res://Assets/Waifu/Rem/RemEgg.tscn"), "ActiveColor": Color.blue},
	},
	"unlockedWaifus": ["NoWaifuSelected", "Rem"],
	"pods": {}
}

func updateMoney():
	get_node("/root/subRoot/UI/MoneyCounter").text = " Money: "+str(data.money)+"g"

func updatePrices():
	var pricesString = ""
	var itemNumber = 0
	for waifu in data.waifus:
		itemNumber = itemNumber + 1
		pricesString = pricesString + "\n  "+str(itemNumber)+") "+waifu+" Eggs - "+str(data.waifus[waifu].EggPrice)+":"+str(data.waifus[waifu].PerFragment)
	
	get_node("/root/subRoot/3D World/Building/Monitor/Sprite3D/Viewport/Label").text = "Prices:"+pricesString

func _ready():
	# Cursor Lock
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Board Price Updater
	get_node("/root/subRoot/3D World").updatePrices()
	updateMoney()