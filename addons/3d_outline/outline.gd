extends ViewportContainer


export var outline_material: Material
export var main_camera_path := NodePath()

onready var root: Viewport = get_node("Viewport")
onready var main_camera: Camera = get_node(main_camera_path)
onready var camera: Camera = get_node("Viewport/Camera")

var nodes := {}


func outline_node(node: MeshInstance) -> void:
	var n := MeshInstance.new()
	n.mesh = node.mesh
	n.material_override = outline_material
	var e := node.connect("tree_exited", self, "remove_node", [n])
	assert(e == OK)
	root.add_child(n)
	nodes[n] = node


func _process(_delta: float) -> void:
	call_deferred("post_process")


func post_process() -> void:
	camera.fov = main_camera.fov
	camera.near = main_camera.near
	camera.far = main_camera.far
	camera.transform = main_camera.global_transform
	for n in nodes:
		n.transform = nodes[n].global_transform


func remove_node(node: MeshInstance) -> void:
	node.queue_free()
	nodes.erase(node)
