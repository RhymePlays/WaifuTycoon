extends StaticBody

export var current_waifu = "Rem"
export var podID = "Pod1"
export var placeID = "GreenPlace"

var placeNode
var eggInstance
var videoInstance = VideoStreamWebm.new()
var emissionMaterialInstance = SpatialMaterial.new()

"""
placeNode.data.pods[podID]['EggCount'] ------------------ Egg Count
placeNode.data.pods[podID]['Multiplier'] ---------------- Multiplier
placeNode.data.waifus[current_waifu]['PerFragment'] ----- Per Fragment
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
	videoInstance.set_file(placeNode.data.waifus[current_waifu].VideoURL)
	$WaifuPodMesh/Display/Viewport/VideoPlayer.stream = videoInstance
	"""$WaifuPodMesh/Display.texture = $WaifuPodMesh/Display/Viewport.get_texture()"""

func updateEgg():
	if eggInstance != null:
		eggInstance.queue_free()
	eggInstance = placeNode.data.waifus[current_waifu].EggScene.instance()
	eggInstance.transform.origin = Vector3(-0.6, 0.2, 0)
	self.add_child(eggInstance)

func updateOthers():
	# Set Egg-Container and Pod-Configurator Color (#BUG: The same material is being used on all the pods. #Fix: Create new mats for new pods)
	emissionMaterialInstance.emission_enabled = true;emissionMaterialInstance.emission_energy = 3
	emissionMaterialInstance.emission = placeNode.data.waifus[current_waifu].ActiveColor
	$EggContainer/EggContainer/Skeleton/Base002.set_surface_material(3, emissionMaterialInstance)
	$PodConfigurator/PodConfiguratorMesh.set_surface_material(3, emissionMaterialInstance)

func updateCounter():
	$WaifuPodMesh/Display/Viewport/EggCounter.text = str(placeNode.data.pods[podID].EggCount)

func updateAutoHarvestor():
	if placeNode.data.pods[podID].AutoHarvestPerXSec != 0.0:
		$AutoHarvestTimer.wait_time = placeNode.data.pods[podID].AutoHarvestPerXSec
		$AutoHarvestTimer.start()
	else:
		$AutoHarvestTimer.stop()

# Functions
func _autoharvestor():
	self.interact()

var interactableByUsersOfXPlace
func interact():
	placeNode.data.pods[podID].EggCount = placeNode.data.pods[podID].EggCount + floor(placeNode.data.waifus[current_waifu].PerFragment * placeNode.data.pods[podID].Multiplier * 100)/100
	updateCounter()

func _ready():
	interactableByUsersOfXPlace = placeID
	placeNode = get_node("/root/subRoot/"+placeID)
	
	# Set default value to the WaifuDataContainingNode
	if (podID in placeNode.data.pods) == false:
		placeNode.data.pods[podID] = {"EggCount": 0, "Multiplier": 1, "AutoHarvestPerXSec": 0, "Waifu": current_waifu}

	updateVideo()
	updateEgg()
	updateOthers()
	updateAutoHarvestor()

	$AutoHarvestTimer.connect("timeout", self, "_autoharvestor")

func _process(_delta):
	if $WaifuPodMesh/Display/Viewport/VideoPlayer.is_playing() == false:
		$WaifuPodMesh/Display/Viewport/VideoPlayer.play()
