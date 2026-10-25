
extends Node2D

@onready var line: Line2D = $Line2D
@onready var ramp_body: StaticBody2D = $StaticBody2D

var drawing := false
var points: PackedVector2Array = []
var min_point_distance := 8.0

func _ready() -> void:
	line.default_color = Color("#d9d4d8")
	line.width = 10.0


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				start_drawing()
			elif drawing:
				finish_drawing()

	elif event is InputEventMouseMotion and drawing:
		add_draw_point()


func start_drawing() -> void:
	drawing = true
	points.clear()
	line.clear_points()

	var p := to_local(get_global_mouse_position())
	points.append(p)
	line.add_point(p)


func add_draw_point() -> void:
	var p := to_local(get_global_mouse_position())

	if points[-1].distance_to(p) >= min_point_distance:
		points.append(p)
		line.add_point(p)


func finish_drawing() -> void:
	drawing = false

	for child in ramp_body.get_children():
		child.queue_free()

	for i in range(points.size() - 1):
		var a: Vector2 = points[i]
		var b: Vector2 = points[i + 1]

		var shape := SegmentShape2D.new()
		shape.a = Vector2.ZERO
		shape.b = b - a

		var collision := CollisionShape2D.new()
		collision.shape = shape
		collision.position = a

		ramp_body.add_child(collision)
