extends Node2D

var command_list = []
var center = Vector2(320, 240)

var progress = 0
var speed = 500 #pixels per second

var NbOfSegments = 100
var radius = 180
var ColorC = global.ColorC
var ColorL = global.ColorL
var NbOfEpicycles = 1
var Thickness = 3

#Note to creator. "You really didn't need those pass keywords floating about. :/"
#"Oh. And you spelt epicycles wrong" -Grammar Nazi

func _draw():
	if command_list.empty(): return
	
	var pixel_dist = 0
	var curr_comm = 0
	while pixel_dist < progress:
		
		if curr_comm > command_list.size()-1: break
		var c = command_list[curr_comm]
		
		var line_length = c.a.distance_to(c.b)
		var dist_left = progress - pixel_dist
		
		if dist_left > line_length:
			draw_line(c.a, c.b, c.col, Thickness, true)
			pixel_dist += line_length
			curr_comm += 1
		else:
			var dist_T = dist_left / line_length
			var last_point = c.a.linear_interpolate(c.b, dist_T)
			draw_line(c.a, last_point, c.col, Thickness, true)
			break

func draw_circle(center, radius, color, thickness):
	var pointsPV = PoolVector2Array()
	
	var prev_point = center + Vector2(1,0) * radius
	for i in range(1, 181):
		var point = center + Vector2(1,0).rotated(deg2rad(i*2)) * radius
		record_draw_command(prev_point, point, color)
		prev_point = point

func div_circumference_in_sgmnts(nbOfSegments, center, radius):
	var pointsPS = PoolVector2Array()
	
	for i in range(nbOfSegments+1):
		var angle_pointS = i * 360 / nbOfSegments - 90
		var point = center + Vector2(cos(deg2rad(angle_pointS)), sin(deg2rad(angle_pointS))) * radius
		pointsPS.push_back(point)
	
	return pointsPS

func draw_epicycles (nbOfEpicycles, nbOfSegments, listOfPositionsOfSegments, color, thickness):
	var Position1 = Vector2()
	var Position2 = Vector2()
	var Times = nbOfEpicycles + 1
	
	var i = 0
	var n = 0
	var t = 0
	    
	for i in range (nbOfSegments):
		Position1 = listOfPositionsOfSegments[i]
		n = floor(i*Times/nbOfSegments)
		
		if i*Times > nbOfSegments:
			t = i * Times - nbOfSegments * n
		else:
			t = i * Times
		
		Position2 = listOfPositionsOfSegments[t]
		
		record_draw_command(Position1, Position2, color)

func record_draw_command(point_a, point_b, color):
	command_list.append({'a': point_a, 'b': point_b, 'col': color})
	progress += point_a.distance_to(point_b)

func _ready():
	
	if global.NbOfSgmnts > 0: NbOfSegments = global.NbOfSgmnts
	if global.RadiusC > 0: radius = global.RadiusC
	if global.NbOfEpcs > 0: NbOfEpicycles = global.NbOfEpcs
	if global.thicc > 0: Thickness = global.thicc
	
	var listPositionOfSegments = div_circumference_in_sgmnts(NbOfSegments, center, radius)
	
	draw_circle(center, radius, ColorC, Thickness)
	draw_epicycles(NbOfEpicycles, NbOfSegments, listPositionOfSegments, ColorL, Thickness)

func _process(delta):
	progress += speed * delta
	update()

