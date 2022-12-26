extends StaticBody

# Params
export var unlockableID = ""
export var nameOfUnlockable = ""
export var bandColor = Color(1,1,1)
export var cost = 0
export var placeID = "GreenPlace"

# Variables
var emissionMaterialInstance = SpatialMaterial.new()

# Constructors
func createUnlockerInstance(unlockableID, placeID, nameOfUnlockable, cost, position, bandColor):
	var unlockerObj = get_node("/root/subRoot/").data.miscPreloads.unlockerScene.instance()
	unlockerObj.nameOfUnlockable = nameOfUnlockable
	unlockerObj.unlockableID = unlockableID
	unlockerObj.cost = cost
	unlockerObj.bandColor = bandColor
	unlockerObj.placeID = placeID
	unlockerObj.transform.origin = position
	return unlockerObj

func createPodSpawnerInstance(podID, placeID):
	var podObj = get_node("/root/subRoot/").data.miscPreloads.podSpawner.instance()
	podObj.podID = podID
	podObj.placeID = placeID
	podObj.cost = get_node("/root/subRoot/").data.miscUnlockerCosts[podID]
	podObj.transform.origin = get_node("/root/subRoot/").data.places[self.placeID].objectLocations[podID]
	return podObj

# Functions
func unlock():
	if self.unlockableID == "ActivateFacility":
		self.get_parent().add_child(createUnlockerInstance(
			"Floor1Pillars",
			self.placeID,
			"Pillars (4x)",
			get_node("/root/subRoot/").data.buildingPartCosts["Floor1Pillars"],
			get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1PillarsUnlocker"],
			Color(0, 1, 0)
		))

		self.get_parent().add_child(createPodSpawnerInstance("Pod1", self.placeID))
		self.get_parent().add_child(createPodSpawnerInstance("Pod2", self.placeID))
		self.get_parent().add_child(createPodSpawnerInstance("Pod3", self.placeID))


	if self.unlockableID == "Floor1Pillars":
		var objScene = get_node("/root/subRoot/").data.buildingPartScenes.FloorXPillars.instance()
		objScene.transform.origin = get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1Pillars"]
		self.get_parent().add_child(objScene)

		self.get_parent().add_child(createUnlockerInstance(
			"Floor1FrontGlass",
			self.placeID,
			"Front Glass",
			get_node("/root/subRoot/").data.buildingPartCosts["Floor1FrontGlass"],
			get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1FrontGlassUnlocker"],
			Color(0, 1, 0)
		))
		self.get_parent().add_child(createUnlockerInstance(
			"Floor1GlassShortL",
			self.placeID,
			"Side Glass",
			get_node("/root/subRoot/").data.buildingPartCosts["Floor1GlassShortL"],
			get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1GlassShortLUnlocker"],
			Color(0, 1, 0)
		))
		self.get_parent().add_child(createUnlockerInstance(
			"Floor1GlassShortR",
			self.placeID,
			"Side Glass",
			get_node("/root/subRoot/").data.buildingPartCosts["Floor1GlassShortR"],
			get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1GlassShortRUnlocker"],
			Color(0, 1, 0)
		))
		self.get_parent().add_child(createUnlockerInstance(
			"Floor1BottomWall",
			self.placeID,
			"Back Wall",
			get_node("/root/subRoot/").data.buildingPartCosts["Floor1BottomWall"],
			get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1BottomWallUnlocker"],
			Color(0, 1, 0)
		))
	
	elif self.unlockableID == "Floor1FrontGlass":
		var objScene = get_node("/root/subRoot/").data.buildingPartScenes.FloorXFrontGlass.instance()
		objScene.transform.origin = get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1FrontGlass"]
		self.get_parent().add_child(objScene)

	elif self.unlockableID == "Floor1GlassShortL":
		var objScene = get_node("/root/subRoot/").data.buildingPartScenes.FloorXGlassShort.instance()
		objScene.transform.origin = get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1GlassShortL"]
		objScene.rotate_y(deg2rad(-180))
		self.get_parent().add_child(objScene)
		
	elif self.unlockableID == "Floor1GlassShortR":
		var objScene = get_node("/root/subRoot/").data.buildingPartScenes.FloorXGlassShort.instance()
		objScene.transform.origin = get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1GlassShortR"]
		self.get_parent().add_child(objScene)
		
	elif self.unlockableID == "Floor1BottomWall":
		var objScene = get_node("/root/subRoot/").data.buildingPartScenes.FloorXBottomWall.instance()
		objScene.transform.origin = get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1BottomWall"]
		self.get_parent().add_child(objScene)

		self.get_parent().add_child(createUnlockerInstance(
			"Floor1TopWall",
			self.placeID,
			"Top Wall",
			get_node("/root/subRoot/").data.buildingPartCosts["Floor1TopWall"],
			get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1TopWallUnlocker"],
			Color(0, 1, 0)
		))
		self.get_parent().add_child(createUnlockerInstance(
			"Monitor",
			self.placeID,
			"Monitor",
			get_node("/root/subRoot/").data.miscUnlockerCosts["Monitor"],
			get_node("/root/subRoot/").data.places[self.placeID].objectLocations["MonitorUnlocker"],
			Color(1, 0, 0)
		))
	
	elif self.unlockableID == "Floor1TopWall":
		var objScene = get_node("/root/subRoot/").data.buildingPartScenes.FloorXTopWall.instance()
		objScene.transform.origin = get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor1TopWall"]
		self.get_parent().add_child(objScene)
	
		self.get_parent().add_child(createUnlockerInstance(
			"Floor2Ground",
			self.placeID,
			"Roof",
			get_node("/root/subRoot/").data.buildingPartCosts["Floor2Ground"],
			get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor2GroundUnlocker"],
			Color(0, 1, 0)
		))

	elif self.unlockableID == "Monitor":
		var objScene = get_node("/root/subRoot/").data.miscPreloads["Monitor"].instance()
		objScene.transform.origin = get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Monitor"]
		self.get_parent().add_child(objScene)
	
	elif self.unlockableID == "Floor2Ground":
		var objScene = get_node("/root/subRoot/").data.buildingPartScenes.FloorXGround.instance()
		objScene.transform.origin = get_node("/root/subRoot/").data.places[self.placeID].objectLocations["Floor2Ground"]
		self.get_parent().add_child(objScene)

var interactableByUsersOfXPlace
func interact():
	if get_node("/root/subRoot/").data.places[placeID].money >= cost:
		get_node("/root/subRoot/").data.places[placeID].money = get_node("/root/subRoot/").data.places[placeID].money - cost
		get_node("/root/subRoot/UI").updateMoney()
		unlock()
		self.queue_free()

# Defaults
func _ready():
	interactableByUsersOfXPlace = placeID
	if unlockableID in get_node("/root/subRoot/").data.places[placeID].unlockedObjects:
		unlock()
		self.queue_free()
	else:
		$Label3D.text = "Unlock "+nameOfUnlockable+"\n"+str(cost)+"g"

		emissionMaterialInstance.emission_enabled = true;emissionMaterialInstance.emission_energy = 3
		emissionMaterialInstance.emission = bandColor
		$MeshInstance.set_surface_material(1, emissionMaterialInstance)
