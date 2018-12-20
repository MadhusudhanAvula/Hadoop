car_name_and_colors = {
  'ford': ['red', 'black', 'white', 'silver', 'gold'],
  	'audi': ['black', 'white'],
  	'volkswagon': ['purple', 'orange', 'green'],
  	'mercedes': ['black'],
}

def get_car_color(car):
    return car_name_and_colors[car]

print(get_car_color('ford'))
