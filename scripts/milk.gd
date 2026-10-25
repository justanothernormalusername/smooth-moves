class_name Milk
extends RigidBody2D
var full := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func fill() -> void:
	if !full:
		$Sprite2D.texture = load("res://assets/milk full.png")
		full = true
