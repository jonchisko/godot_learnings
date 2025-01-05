class_name WeightedTable


var items: Array[Dictionary] = []
var weight_sum = 0

func add_item(item, weight: int):
	self.items.append({"item": item, "weight": weight})
	self.weight_sum += weight


func pick_item():
	var chosen_weight = randi_range(1, self.weight_sum)
	var iteration_sum = 0
	
	for item_object in items:
		iteration_sum += item_object["weight"]
		if chosen_weight <= iteration_sum:
			return item_object["item"]
