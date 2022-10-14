extends StaticBody

func interact():
	get_node("/root/subRoot/3D World").data.money = get_node("/root/subRoot/3D World").data.money + get_node("/root/subRoot/3D World").data.waifus[get_parent().get_parent().current_waifu].EggPrice * get_node("/root/subRoot/3D World").data.pods[get_parent().get_parent().podID].EggCount
	get_node("/root/subRoot/3D World").updateMoney()

	get_node("/root/subRoot/3D World").data.pods[get_parent().get_parent().podID].EggCount = 0
	get_parent().get_parent().updateCounter()