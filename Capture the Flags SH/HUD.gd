extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Capture the Flags"
	$MessageLabel.show()
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

func update_scoreP1(scoreP1):
	$ScoreLabelP1.text = str(scoreP1)

func update_scoreP2(scoreP2):
	$ScoreLabelP2.text = str(scoreP2)
	
func update_timer(timerCounter):
	$TimerLabel.text = str(timerCounter)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
