extends Node

var data = {
	"buildingPartScenes": {
		"FloorXTopWall": preload("res://Assets/Building/FloorXTopWall.tscn"),
		"FloorXGlassLong": preload("res://Assets/Building/FloorXGlassLong.tscn"),
		"FloorXGlassShort": preload("res://Assets/Building/FloorXGlassShort.tscn"),
		"FloorXFrontGlass": preload("res://Assets/Building/FloorXFrontGlass.tscn"),
		"FloorXBottomWall": preload("res://Assets/Building/FloorXBottomWall.tscn"),
		"FloorXPillars": preload("res://Assets/Building/FloorXPillars.tscn"),
		"FloorXGround": preload("res://Assets/Building/FloorXGround.tscn"),
	},
	"buildingPartCosts": {
		"Floor1Pillars": 0,
		"Floor1FrontGlass": 0,
		"Floor1GlassShortL": 0,
		"Floor1GlassShortR": 0,
		"Floor1BottomWall": 0,
		"Floor1TopWall": 0,
		"Floor2Ground": 0,
	},
	"miscPreloads": {
		"Monitor" : preload("res://Assets/UnlockableObjects/Monitor.tscn"),
		"unlockerScene": preload("res://Assets/UnlockableObjects/UnlockableObjectPlaceholder.tscn"),
		"podSpawner": preload("res://Assets/Waifu/WaifuPod/PodSpawner.tscn"),
		"waifuPod": preload("res://Assets/Waifu/WaifuPod/WaifuPod.tscn"),
	},
	"miscUnlockerCosts": {
		"Monitor": 0,
		"Pod1": 0,
		"Pod2": 5000,
		"Pod3": 10000,
	},
	
	"waifus": {
		"NoWaifuSelected": {"VideoURL": "res://Assets/Waifu/NoWaifuSelected/NoWaifuSelected.webm", "EggPrice": 0, "PerFragment": 0, "EggScene": preload("res://Assets/Waifu/NoWaifuSelected/BlankEgg.escn"), "ActiveColor": Color.white},
		"Rem": {"VideoURL": "res://Assets/Waifu/Rem/Rem.webm", "EggPrice": 10, "PerFragment": 0.1, "EggScene": preload("res://Assets/Waifu/Rem/RemEgg.tscn"), "ActiveColor": Color.blue},
	},
	
	"places": {
		"GreenPlace": {
			"money": 0,
			"unlockedWaifus": ["NoWaifuSelected", "Rem"],
			# "unlockedObjects": ["Floor1Pillars", "Floor1FrontGlass", "Floor1GlassShortL", "Floor1GlassShortR", "Floor1BottomWall", "Monitor", "Floor1TopWall", "Floor2Ground"],
			"unlockedObjects": [],
			"objectLocations": {
				"Pod1": Vector3(1.875, 0.2, 4.5),
				"Pod2": Vector3(0.313, 0.2, 4.5),
				"Pod3": Vector3(-1.25, 0.2, 4.5),
				"ActivateFacilityUnlocker": Vector3(2.5, 0.469, 0.125),
				"Floor1PillarsUnlocker": Vector3(2.813, 0.469, 4.813),
				"Floor1FrontGlassUnlocker": Vector3(2.813, 0.469, 3.25),
				"Floor1GlassShortLUnlocker": Vector3(0.313, 0.469, 4.813),
				"Floor1GlassShortRUnlocker": Vector3(0.313, 0.469, -4.875),
				"Floor1BottomWallUnlocker": Vector3(-2.813, 0.469, -0.188),
				"Floor1TopWallUnlocker": Vector3(2.5, 0.469, 0.125),
				"MonitorUnlocker": Vector3(-2.5, 0.469, -0.188),
				"Floor2GroundUnlocker": Vector3(2.5, 0.469, 0.125),
				"Floor1Pillars": Vector3(0, 0, 0),
				"Floor1FrontGlass": Vector3(0, 0, 0),
				"Floor1GlassShortL": Vector3(0, 0, 0),
				"Floor1GlassShortR": Vector3(0, 0, 0),
				"Floor1BottomWall": Vector3(0, 0, 0),
				"Floor1TopWall": Vector3(0, 0, 0),
				"Monitor": Vector3(-2.797, 1.375, 0),
				"Floor2Ground": Vector3(0, 3.2, 0),
			},
			"pods": {}
		}
	},
}
