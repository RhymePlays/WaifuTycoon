extends StaticBody

export var current_waifu = "Rem"
export var podID = "Pod1"

var waifuDataContainingNode
var eggInstance
var videoInstance = VideoStreamWebm.new()
var emissionMaterialInstance = SpatialMaterial.new()

"""
waifuDataContainingNode.data.pods[podID]['EggCount'] ------------------ Egg Count
waifuDataContainingNode.data.pods[podID]['Multiplier'] ---------------- Multiplier
waifuDataContainingNode.data.waifus[current_waifu]['PerFragment'] ----- Per Fragment
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
	videoInstance.set_file(waifuDataContainingNode.data.waifus[current_waifu].VideoURL)
	$WaifuPodMesh/Display/Viewport/VideoPlayer.stream = videoInstance
	"""$WaifuPodMesh/Display.texture = $WaifuPodMesh/Display/Viewport.get_texture()"""

func updateEgg():
	if eggInstance != null:
		eggInstance.queue_free()
	eggInstance = waifuDataContainingNode.data.waifus[current_waifu].EggScene.instance()
	eggInstance.transform.origin = Vector3(-0.6, 0.2, 0)
	self.add_child(eggInstance)

func updateOthers():
	# Set Egg-Container and Pod-Configurator Color (#BUG: The same material is being used on all the pods. #Fix: Create new mats for new pods)
	emissionMaterialInstance.emission_enabled = true;emissionMaterialInstance.emission_energy = 3.5
	emissionMaterialInstance.emission = waifuDataContainingNode.data.waifus[current_waifu].ActiveColor
	$EggContainer/EggContainer/Skeleton/Base002.set_surface_material(3, emissionMaterialInstance)
	$PodConfigurator/PodConfiguratorMesh.set_surface_material(3, emissionMaterialInstance)

func updateCounter():
	$WaifuPodMesh/Display/Viewport/EggCounter.text = str(waifuDataContainingNode.data.pods[podID].EggCount)

func updateAutoHarvestor():
	if waifuDataContainingNode.data.pods[podID].AutoHarvestPerXSec != 0.0:
		$AutoHarvestTimer.wait_time = waifuDataContainingNode.data.pods[podID].AutoHarvestPerXSec
		$AutoHarvestTimer.start()
	else:
		$AutoHarvestTimer.stop()

# Functions
func _autoharvestor():
	self.interact()

func interact():
	waifuDataContainingNode.data.pods[podID].EggCount = waifuDataContainingNode.data.pods[podID].EggCount + floor(waifuDataContainingNode.data.waifus[current_waifu].PerFragment * waifuDataContainingNode.data.pods[podID].Multiplier * 100)/100
	updateCounter()

func _ready():
	waifuDataContainingNode = get_node("/root/subRoot/GreenPlace")
	
	# Set default value to the WaifuDataContainingNode
	if (podID in waifuDataContainingNode.data.pods) == false:
		waifuDataContainingNode.data.pods[podID] = {"EggCount": 0, "Multiplier": 1, "AutoHarvestPerXSec": 0, "Waifu": current_waifu}

	updateVideo()
	updateEgg()
	updateOthers()
	updateAutoHarvestor()

	$AutoHarvestTimer.connect("timeout", self, "_autoharvestor")

func _process(_delta):
	if $WaifuPodMesh/Display/Viewport/VideoPlayer.is_playing() == false:
		$WaifuPodMesh/Display/Viewport/VideoPlayer.play()
