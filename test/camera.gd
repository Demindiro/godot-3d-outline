extends Camera


var pan := 0.0
var tilt := 0.0

export var angular_speed := 0.1
export var linear_speed := 3.0


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pan -= event.relative.x * angular_speed
		tilt -= event.relative.y * angular_speed


func _process(delta: float) -> void:
	var move := Vector3()
	var act_map := {
		"up": Vector3.UP,
		"down": Vector3.DOWN,
		"left": Vector3.LEFT,
		"right": Vector3.RIGHT,
		"forward": Vector3.FORWARD,
		"back": Vector3.BACK,
	}
	for a in act_map:
		if Input.is_action_pressed(a):
			move += act_map[a]
	transform.basis = Basis(Vector3.UP * pan) * Basis(Vector3.RIGHT * tilt)
	transform.origin += transform.basis * move * linear_speed * delta
