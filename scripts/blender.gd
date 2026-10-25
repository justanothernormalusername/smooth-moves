extends Node2D

@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var score_label: RichTextLabel = $"../Player/Control/RichTextLabel"
var score := 0

@onready var positions := [
	$"../Spawns/Marker2D", 
	$"../Spawns/Marker2D2", 
	$"../Spawns/Marker2D3", 
	$"../Spawns/Marker2D4", 
	$"../Spawns/Marker2D5", 
	$"../Spawns/Marker2D6", 
	$"../Spawns/Marker2D7", 
	$"../Spawns/Marker2D8"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		if body is Milk and !body.full:
			return
		$BlenderJuice.show()
		if body.scene_file_path != "":
			var body_scene = load(body.scene_file_path)
			var clone = body_scene.instantiate()
			var random_marker = positions.pick_random()
			clone.global_position = random_marker.global_position
			body.get_parent().add_child(clone)
		body.queue_free()
		audio_stream.play()
		score += 1
		score_label.text = str(score)
		
