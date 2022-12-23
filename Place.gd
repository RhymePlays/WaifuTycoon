extends Spatial

export var placeID = "GreenWorld"

func _ready():
	if (placeID in get_node("/root/subRoot").data.places) == false:
		get_node("/root/subRoot").data.places[placeID] = {"money": 0, "unlockedWaifus": ["NoWaifuSelected", "Rem"], "pods": {}}