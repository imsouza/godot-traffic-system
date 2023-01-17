extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var color = 'green'
onready var obj = get_node("MeshInstance")
var redColor = SpatialMaterial.new()
var greenColor = SpatialMaterial.new()
var yellowColor = SpatialMaterial.new()

func _ready():
	redColor.albedo_color = Color(1, 0, 0)
	greenColor.albedo_color = Color(0, 1, 0)
	yellowColor.albedo_color = Color(1, 1, 0)
	if color == 'green':
		obj.material_override = greenColor
		$Greenlight.start()
	elif color == 'red':
		obj.material_override = redColor
		$Redlight.start()
	elif color == 'yellow':
		obj.material_override = yellowColor
		$Yellowlight.start()
	
func _on_Yellowtimer_timeout():
	color = 'red'
	obj.material_override = redColor
	$Redlight.start()

func _on_Redlight_timeout():
	color = 'green'
	obj.material_override = greenColor
	$Greenlight.start()

func _on_Greenlight_timeout():
	color = 'yellow'
	obj.material_override = yellowColor
	$Yellowlight.start()
