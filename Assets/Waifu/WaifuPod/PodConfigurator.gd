extends StaticBody

var waifus = []

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
		"amountToBeAdded": floor(get_parent().placeNode.data.pods[self.get_parent().podID].Multiplier * addPercentage * 100)/100,
		"priceToPay": floor(get_parent().placeNode.data.pods[self.get_parent().podID].Multiplier * costPercantage * 500 * 100)/100
	}

func autoHarvestorCalculator(addPercentage=0.05, costPercantage=0.2):
	return {
		"amountToBeReduced": floor(get_parent().placeNode.data.pods[self.get_parent().podID].AutoHarvestPerXSec * addPercentage * 100)/100,
		"priceToPay": floor((10/get_parent().placeNode.data.pods[self.get_parent().podID].AutoHarvestPerXSec) * (costPercantage * 5000 * 100))/100 #AutoHarvestPerXSec needs to be devided by the Post-Unlock-AutoHarvestPerXSec
	}

# Updaters
func updateConfigStats():
	$ConfigUI/PodStats.text = "Egg Per Fragment: "+str(get_parent().placeNode.data.waifus[self.get_parent().current_waifu].PerFragment)+"\nPod Multiplier: "+str(get_parent().placeNode.data.pods[self.get_parent().podID].Multiplier)+"x\nAuto-Harvest: "+str(get_parent().placeNode.data.pods[self.get_parent().podID].AutoHarvestPerXSec)+"s"

func updateUpgradesList():
	for child in $ConfigUI/UpgradesContainerScroll/UpgradesContainer.get_children():
		child.queue_free()
	
	# Auto-Harvestor Upgrader
	if get_parent().placeNode.data.pods[self.get_parent().podID].AutoHarvestPerXSec == 0:
		$ConfigUI/UpgradesContainerScroll/UpgradesContainer.add_child(buttonConstructor("Unlock Auto-Harvestor = 1000", GradientTexture2D, "_buyAutoHarvestor"))
	else:
		if get_parent().placeNode.data.pods[self.get_parent().podID].AutoHarvestPerXSec - autoHarvestorCalculator().amountToBeReduced > 0.5:
			$ConfigUI/UpgradesContainerScroll/UpgradesContainer.add_child(buttonConstructor("Auto-Harvestor -"+str(autoHarvestorCalculator().amountToBeReduced)+" = "+str(autoHarvestorCalculator().priceToPay)+"g", GradientTexture2D, "_buyAutoHarvestorUpgrade"))

	# Multiplier Upgrader
	if get_parent().placeNode.data.pods[self.get_parent().podID].Multiplier + multiplierCalculator().amountToBeAdded < 100:
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
	if get_parent().placeNode.data.money >= cost:
		get_parent().placeNode.data.money = get_parent().placeNode.data.money - cost
		get_parent().placeNode.data.pods[self.get_parent().podID].AutoHarvestPerXSec = 10
		
		get_parent().placeNode.updateMoney()
		updateConfigStats()
		updateUpgradesList()
		get_parent().updateAutoHarvestor()

func _buyAutoHarvestorUpgrade():
	if get_parent().placeNode.data.money >= autoHarvestorCalculator().priceToPay:
		get_parent().placeNode.data.money = get_parent().placeNode.data.money - autoHarvestorCalculator().priceToPay
		get_parent().placeNode.data.pods[self.get_parent().podID].AutoHarvestPerXSec = get_parent().placeNode.data.pods[self.get_parent().podID].AutoHarvestPerXSec - autoHarvestorCalculator().amountToBeReduced

		get_parent().placeNode.updateMoney()
		updateConfigStats()
		updateUpgradesList()
		get_parent().updateAutoHarvestor()

func _buyMultiplierUpgrade():
	if get_parent().placeNode.data.money >= multiplierCalculator().priceToPay:
		get_parent().placeNode.data.money = get_parent().placeNode.data.money - multiplierCalculator().priceToPay
		get_parent().placeNode.data.pods[self.get_parent().podID].Multiplier = get_parent().placeNode.data.pods[self.get_parent().podID].Multiplier + multiplierCalculator().amountToBeAdded
		
		get_parent().placeNode.updateMoney()
		updateConfigStats()
		updateUpgradesList()

var interactableByUsersOfXPlace
func interact():
	$ConfigUI.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_node("/root/subRoot/SelfPlayer").controlsEnabled = false

	$ConfigUI/ChooseWaifuDropdown.clear()
	waifus.clear()
	for waifu in get_parent().placeNode.data.waifus:
		if waifu in get_parent().placeNode.data.unlockedWaifus:
			$ConfigUI/ChooseWaifuDropdown.add_item(waifu)
			waifus.append(waifu)

	$ConfigUI/ChooseWaifuDropdown.select(waifus.find(self.get_parent().current_waifu, 0))
	updateConfigStats()
	updateUpgradesList()

func _ready():
	interactableByUsersOfXPlace = get_parent().place
	$ConfigUI/CloseButton.connect("pressed", self, "_closePanel")
	$ConfigUI/ChooseWaifuDropdown.connect("item_selected", self, "_waifuSelected")

