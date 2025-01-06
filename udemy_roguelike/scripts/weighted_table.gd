class_name WeightedTable


var items: Array[Dictionary] = []
var weight_sum = 0

func add_item(item, weight: int):
	self.items.append({"item": item, "weight": weight})
	self.weight_sum += weight


func remove_item(item_to_remove):
	self.items = self.items.filter(func (item): return item["item"] != item_to_remove)
	self.weight_sum = 0
	for item in self.items:
		self.weight_sum += item["weight"]
	

func pick_item(exclude: Array = []):
	var adjusted_items: Array[Dictionary] = self.items
	var adjusted_weight_sum = self.weight_sum
	
	if exclude.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		for item in items:
			if item["item"] in exclude:
				continue
			adjusted_items.append(item)
			adjusted_weight_sum += item["weight"]
	
	var chosen_weight = randi_range(1, adjusted_weight_sum)
	var iteration_sum = 0
	
	for item_object in adjusted_items:
		iteration_sum += item_object["weight"]
		if chosen_weight <= iteration_sum:
			return item_object["item"]
