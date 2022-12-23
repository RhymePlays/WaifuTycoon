extends StaticBody

var waifus = []
onready var worldDataNode = get_node("/root/subRoot/")

# Constructors/Calculator
func buttonConstructor(text, icon, onClickFunc):
	var returnValue = Button.new()
	returnValue.flat = true
	returnValue.icon = icon
	returnValue.text = text
	returnValue.align = 0
	returnValue.connect("pressed", self, onClickFunc)
	return returnValue

func multiplierCalculator(addPercentage=0.05, costPercantage=0.05):
	return {
		"amountToBeAdded": floor(worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].Multiplier * addPercentage * 100)/100,
		"priceToPay": floor(worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].Multiplier * costPercantage * 500 * 100)/100
	}

func autoHarvestorCalculator(addPercentage=0.05, costPercantage=0.2):
	return {
		"amountToBeReduced": floor(worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].AutoHarvestPerXSec * addPercentage * 100)/100,
		"priceToPay": floor((10/worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].AutoHarvestPerXSec) * (costPercantage * 5000 * 100))/100 #AutoHarvestPerXSec needs to be devided by the Post-Unlock-AutoHarvestPerXSec
	}

# Updaters
func updateConfigStats():
	$ConfigUI/PodStats.text = "Egg Per Fragment: "+str(worldDataNode.data.waifus[self.get_parent().current_waifu].PerFragment)+"\nPod Multiplier: "+str(worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].Multiplier)+"x\nAuto-Harvest: "+str(worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].AutoHarvestPerXSec)+"s"

func updateUpgradesList():
	for child in $ConfigUI/UpgradesContainerScroll/UpgradesContainer.get_children():
		child.queue_free()
	
	# Auto-Harvestor Upgrader
	if worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].AutoHarvestPerXSec == 0:
		$ConfigUI/UpgradesContainerScroll/UpgradesContainer.add_child(buttonConstructor("Unlock Auto-Harvestor = 1000", GradientTexture2D, "_buyAutoHarvestor"))
	else:
		if worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].AutoHarvestPerXSec - autoHarvestorCalculator().amountToBeReduced > 0.5:
			$ConfigUI/UpgradesContainerScroll/UpgradesContainer.add_child(buttonConstructor("Auto-Harvestor -"+str(autoHarvestorCalculator().amountToBeReduced)+" = "+str(autoHarvestorCalculator().priceToPay)+"g", GradientTexture2D, "_buyAutoHarvestorUpgrade"))

	# Multiplier Upgrader
	if worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].Multiplier + multiplierCalculator().amountToBeAdded < 100:
		$ConfigUI/UpgradesContainerScroll/UpgradesContainer.add_child(buttonConstructor("Multiplier +"+str(multiplierCalculator().amountToBeAdded)+" = "+str(multiplierCalculator().priceToPay)+"g", GradientTexture2D, "_buyMultiplierUpgrade"))

# Functions
func _closePanel():
	$ConfigUI.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_node("/root/subRoot/SelfPlayer").controlsEnabled = true

func _waifuSelected(itemIndex):
	self.get_parent().changeWaifu(waifus[itemIndex])
	updateConfigStats()

func _buyAutoHarvestor(cost=1000):
	if worldDataNode.data.places[get_parent().placeID].money >= cost:
		worldDataNode.data.places[get_parent().placeID].money = worldDataNode.data.places[get_parent().placeID].money - cost
		worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].AutoHarvestPerXSec = 10
		
		get_node("/root/subRoot/UI").updateMoney()
		updateConfigStats()
		updateUpgradesList()
		get_parent().updateAutoHarvestor()

func _buyAutoHarvestorUpgrade():
	if worldDataNode.data.places[get_parent().placeID].money >= autoHarvestorCalculator().priceToPay:
		worldDataNode.data.places[get_parent().placeID].money = worldDataNode.data.places[get_parent().placeID].money - autoHarvestorCalculator().priceToPay
		worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].AutoHarvestPerXSec = worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].AutoHarvestPerXSec - autoHarvestorCalculator().amountToBeReduced

		get_node("/root/subRoot/UI").updateMoney()
		updateConfigStats()
		updateUpgradesList()
		get_parent().updateAutoHarvestor()

func _buyMultiplierUpgrade():
	if worldDataNode.data.places[get_parent().placeID].money >= multiplierCalculator().priceToPay:
		worldDataNode.data.places[get_parent().placeID].money = worldDataNode.data.places[get_parent().placeID].money - multiplierCalculator().priceToPay
		worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].Multiplier = worldDataNode.data.places[get_parent().placeID].pods[self.get_parent().podID].Multiplier + multiplierCalculator().amountToBeAdded
		
		get_node("/root/subRoot/UI").updateMoney()
		updateConfigStats()
		updateUpgradesList()

var interactableByUsersOfXPlace
func interact():
	$ConfigUI.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_node("/root/subRoot/SelfPlayer").controlsEnabled = false

	$ConfigUI/ChooseWaifuDropdown.clear()
	waifus.clear()
	for waifu in worldDataNode.data.waifus:
		if waifu in worldDataNode.data.places[get_parent().placeID].unlockedWaifus:
			$ConfigUI/ChooseWaifuDropdown.add_item(waifu)
			waifus.append(waifu)

	$ConfigUI/ChooseWaifuDropdown.select(waifus.find(self.get_parent().current_waifu, 0))
	updateConfigStats()
	updateUpgradesList()

func _ready():
	interactableByUsersOfXPlace = get_parent().placeID
	$ConfigUI/CloseButton.connect("pressed", self, "_closePanel")
	$ConfigUI/ChooseWaifuDropdown.connect("item_selected", self, "_waifuSelected")
