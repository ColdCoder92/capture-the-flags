extends Node

export(PackedScene) var item_scene
var scoreP1
var scoreP2
var timerCounter

func _ready():
	randomize()

func game_over():
	$ItemTimer.stop()
	$GameTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	get_tree().call_group("mobs", "queue_free")
	scoreP1 = 0
	scoreP2 = 0
	timerCounter = 15
	$Player1.start($StartPosition1.position)
	$Player2.start($StartPosition2.position)
	$StartTimer.start()
	$HUD.update_scoreP1(scoreP1)
	$HUD.update_scoreP2(scoreP2)
	$HUD.update_timer(timerCounter)
	$HUD.show_message("Get Ready")
	$Music.play()

func _on_ItemTimer_timeout():
	# Create a new instance of the Mob scene.
	var item = item_scene.instance()
	# Choose a random location on Path2D.
	var item_spawn_location = get_node("ItemSpawn/SpawnPath")
	item_spawn_location.offset = randi()
	# Set the mob's position to a random location.
	item.position = item_spawn_location.position
	add_child(item)

func _on_StartTimer_timeout():
	$ItemTimer.start()
	$GameTimer.start()

func _on_GameTimer_timeout():
	timerCounter -= 1
	$HUD.update_timer(timerCounter)
	if (timerCounter == 0):
		game_over()

func p1HitLoss():
	var hitLoss
	if (scoreP1 > 2):
		hitLoss = 3
	elif (scoreP1 == 2):
		hitLoss = 2
	elif (scoreP1 == 1):
		hitLoss = 1
	scoreP1 = scoreP1 - hitLoss
	$HUD.update_scoreP1(scoreP1)

func p2HitLoss():
	var hitLoss
	if (scoreP2 > 2):
		hitLoss = 3
	elif (scoreP2 == 2):
		hitLoss = 2
	elif (scoreP2 == 1):
		hitLoss = 1
	scoreP1 = scoreP1 - hitLoss
	$HUD.update_scoreP2(scoreP2)

func _on_Player1_body_entered(body):
#	if (body == $Player2):
#		p1HitLoss()
#	else:
		#$Player1.collect()
	scoreP1 += 1
	$HUD.update_scoreP1(scoreP1)

func _on_Player2_body_entered(body):
#	if (body == $Player1):
#		p2HitLoss()
#	else:
		#$Player2.collect()
	scoreP2 += 1
	$HUD.update_scoreP2(scoreP2)

func _on_Item_body_entered(body):
	queue_free()
	$CollisionShape2D.set_deferred("disabled", true)

