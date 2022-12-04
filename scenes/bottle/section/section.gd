class_name Section extends Polygon2D


func _ready():
	self.scale.y = 1 / float(AutoLoad.bottle_capacity)


func paint(color: Color):
	self.color = color


func place(location):
	self.position.y = (-120.0 / AutoLoad.bottle_capacity) * (1 + ((location - 1) * 2)) +120
