extends StaticBody

func interact():
	get_node("/root/subRoot/GreenPlace").data.money = get_node("/root/subRoot/GreenPlace").data.money + get_node("/root/subRoot/GreenPlace").data.waifus[get_parent().get_parent().current_waifu].EggPrice * get_node("/root/subRoot/GreenPlace").data.pods[get_parent().get_parent().podID].EggCount
	get_node("/root/subRoot/GreenPlace").updateMoney()

	get_node("/root/subRoot/GreenPlace").data.pods[get_parent().get_parent().podID].EggCount = 0
	get_parent().get_parent().updateCounter()