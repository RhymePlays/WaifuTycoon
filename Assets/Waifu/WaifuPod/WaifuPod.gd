extends StaticBody

export var current_waifu = "Rem"
export var podID = "Pod1"
export var placeID = "GreenPlace"

onready var worldDataNode = get_node("/root/subRoot/")
var eggInstance
var videoInstance = VideoStreamWebm.new()
var emissionMaterialInstance = SpatialMaterial.new()

"""
worldDataNode.data.pods[podID]['EggCount'] ------------------ Egg Count
worldDataNode.data.pods[podID]['Multiplier'] ---------------- Multiplier
worldDataNode.data.waifus[current_waifu]['PerFragment'] ----- Per Fragment
"""

# Pod Updaters
func changeWaifu(waifuID):
	if current_waifu != waifuID:
		$EggContainer/StaticBody.interact()

		current_waifu = waifuID
		updateVideo()
		updateEgg()
		updateOthers()

func updateVideo():
	videoInstance.set_file(worldDataNode.data.waifus[current_waifu].VideoURL)
	$WaifuPodMesh/Display/Viewport/VideoPlayer.stream = videoInstance
	"""$WaifuPodMesh/Display.texture = $WaifuPodMesh/Display/Viewport.get_texture()"""

func updateEgg():
	if eggInstance != null:
		eggInstance.queue_free()
	eggInstance = worldDataNode.data.waifus[current_waifu].EggScene.instance()
	eggInstance.transform.origin = Vector3(-0.6, 0.2, 0)
	self.add_child(eggInstance)

func updateOthers():
	# Set Egg-Container and Pod-Configurator Color (#BUG: The same material is being used on all the pods. #Fix: Create new mats for new pods)
	emissionMaterialInstance.emission_enabled = true;emissionMaterialInstance.emission_energy = 3
	emissionMaterialInstance.emission = worldDataNode.data.waifus[current_waifu].ActiveColor
	$EggContainer/EggContainer/Skeleton/Base002.set_surface_material(3, emissionMaterialInstance)
	$PodConfigurator/PodConfiguratorMesh.set_surface_material(3, emissionMaterialInstance)

func updateCounter():
	$WaifuPodMesh/Display/Viewport/EggCounter.text = str(worldDataNode.data.places[placeID].pods[podID].EggCount)

func updateAutoHarvestor():
	if worldDataNode.data.places[placeID].pods[podID].AutoHarvestPerXSec != 0.0:
		$AutoHarvestTimer.wait_time = worldDataNode.data.places[placeID].pods[podID].AutoHarvestPerXSec
		$AutoHarvestTimer.start()
	else:
		$AutoHarvestTimer.stop()

# Functions
func _autoharvestor():
	self.interact()

var interactableByUsersOfXPlace
func interact():
	worldDataNode.data.places[placeID].pods[podID].EggCount = worldDataNode.data.places[placeID].pods[podID].EggCount + floor(worldDataNode.data.waifus[current_waifu].PerFragment * worldDataNode.data.places[placeID].pods[podID].Multiplier * 100)/100
	updateCounter()

func _ready():
	interactableByUsersOfXPlace = placeID
