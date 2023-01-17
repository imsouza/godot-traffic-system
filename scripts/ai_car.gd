extends PathFollow

signal path_end_reached
const PATH_TRANSMITTER = 8
export var car_velocity: float = 2
var _new_path
var trafficLightColor
onready var color = 'car'
onready var _raycast = $RayCast
onready var _raycast2 = $RayCast2


func _process(delta):
	# Movement
	# Check for next path
	if _raycast2.is_colliding():
		trafficLightColor = _check_roadlight()
	if _raycast.is_colliding():
		_check_raycast_collisions()
	if unit_offset == 1:
		emit_signal("path_end_reached")
	
	if trafficLightColor == null or trafficLightColor == 'green':
		offset += car_velocity * delta
	elif trafficLightColor == 'yellow':
		offset += car_velocity * delta * 0.5
	
	trafficLightColor = null


func _on_AICar_path_end_reached():
	# Remove current path when end is reached
	var old_path = self.get_parent()
	old_path.remove_child(self)
	# Get new path
	if _new_path != null:
		_new_path.add_child(self)
	# Smoothing the transit
	unit_offset = 0


func _check_raycast_collisions():
	var _collision_object = _raycast.get_collider()
	if _collision_object.get_collision_layer_bit(PATH_TRANSMITTER):
		# Ask transmitter for number of paths
		var number_of_paths: int = 0 
		for child in _collision_object.get_children():
			if child is Path:
				number_of_paths += 1
		# Get random path between 1 (always given) and number of paths
		_new_path = _collision_object.get_child(round(rand_range(1, number_of_paths)))

func _check_roadlight():
	var trafficLightColor = _raycast2.get_collider().get('color')
	return trafficLightColor
