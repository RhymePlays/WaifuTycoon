extends Node

var data = {
	"waifuPod": preload("res://Assets/Waifu/WaifuPod/WaifuPod.tscn"),
	"waifus": {
		"NoWaifuSelected": {"VideoURL": "res://Assets/Waifu/NoWaifuSelected/NoWaifuSelected.webm", "EggPrice": 0, "PerFragment": 0, "EggScene": preload("res://Assets/Waifu/NoWaifuSelected/BlankEgg.escn"), "ActiveColor": Color.white},
		"Rem": {"VideoURL": "res://Assets/Waifu/Rem/Rem.webm", "EggPrice": 10, "PerFragment": 0.1, "EggScene": preload("res://Assets/Waifu/Rem/RemEgg.tscn"), "ActiveColor": Color.blue},
	},
	
	"places": {
		"GreenPlace": {
			"money": 0,
			"unlockedWaifus": ["NoWaifuSelected", "Rem"],
			"pods": {}
		}
	},
}