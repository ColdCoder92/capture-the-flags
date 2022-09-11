extends RigidBody2D

signal collected

func _ready():
	$AnimatedSprite.playing = true
	var item_anims = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = item_anims[randi() % item_anims.size()]

func _on_Item_body_entered(body):
	queue_free()
	emit_signal("collected")
	$CollisionShape2D.set_deferred("disabled", true)
