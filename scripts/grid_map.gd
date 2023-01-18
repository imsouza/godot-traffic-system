extends GridMap

onready var _straight_lanes = preload("res://scenes/straight_lanes.tscn")
onready var _curve_lanes = preload("res://scenes/curve_lanes.tscn")
onready var _t_crossing_lanes = preload("res://scenes/t_crossing_lanes.tscn")
onready var _crossing_lanes = preload("res://scenes/crossing_lanes.tscn")


const CROSSING = 1
const CURVE = 2 
const STRAIGHT = 3
const TCROSSING = 4

# Orientation
const NORTH = 10
const EAST = 16
const SOUTH = 0
const WEST = 22


func _ready():
	for cell in get_used_cells():
		if get_cell_item(cell.x, cell.y, cell.z) == STRAIGHT:
			_add_traffic_nodes(cell, _straight_lanes)
		if get_cell_item(cell.x, cell.y, cell.z) == CURVE:
			_add_traffic_nodes(cell, _curve_lanes)
		if get_cell_item(cell.x, cell.y, cell.z) == TCROSSING:
			_add_traffic_nodes(cell, _t_crossing_lanes)
		if get_cell_item(cell.x, cell.y, cell.z) == CROSSING:
			_add_traffic_nodes(cell, _crossing_lanes)


func _add_traffic_nodes(cell, traffic_node):
	var traffic_node_instance = traffic_node.instance()
	traffic_node_instance.translation = map_to_world(cell.x, cell.y, cell.z)
	if get_cell_item_orientation(cell.x, cell.y, cell.z) == NORTH:
		traffic_node_instance.rotation_degrees.y += 180
	if get_cell_item_orientation(cell.x, cell.y, cell.z) == EAST:
		traffic_node_instance.rotation_degrees.y += 90
	if get_cell_item_orientation(cell.x, cell.y, cell.z) == SOUTH:
		traffic_node_instance.rotation_degrees.y += 0
	if get_cell_item_orientation(cell.x, cell.y, cell.z) == WEST:
		traffic_node_instance.rotation_degrees.y += 270
	add_child(traffic_node_instance)
