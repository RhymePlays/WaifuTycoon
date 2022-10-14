extends Spatial

func _ready():
	$AnimationPlayer.current_animation = "Armature001Action"
	loop()

func loop():
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play()
	loop()