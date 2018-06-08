extends Node

var instruction = global.instruction

func _ready():
    set_process_input(true)


func _input(event):
    if event.is_action_pressed("ui_accept"): get_tree().change_scene("res://Content/Scenes/Menu/Menu.tscn"); global.NbOfEpcs = 0.0; global.NbOfSgmnts = 0; global.RadiusC = 0; global.thicc = 0; global.ColorC = Color(1.0, 1.0, 0.0); global.ColorL = Color(0.6, 0.0, 1.0);

func _draw():
	
	var radius = 280;
	
	if (global.RadiusC > 0):
		
		radius = global.RadiusC;
		
	
	var NbOfSegments = 150
	
	if (global.NbOfSgmnts > 0):
		
		 NbOfSegments = global.NbOfSgmnts;
		
	
	var Rate_of_Change = 0.1
	
	var NbOfEpicicles = 1;
	
	if (global.NbOfEpcs > 0):
		
		NbOfEpicicles = global.NbOfEpcs;
		
	
	var Thickness = 1;
	
	if ( global.thicc > 0):
		
		Thickness = global.thicc;
		
	
	var center = Vector2(512, 300)
	
	var ColorC = global.ColorC
	
	var ColorL = global.ColorL
	
	var listPositionOfSegments = div_circumference_in_sgmnts(NbOfSegments, center, radius);
	
	draw_circly(center, radius, ColorC, Thickness)
	
	draw_epicicles(NbOfEpicicles, NbOfSegments, listPositionOfSegments, ColorL, Thickness);
	
	
	
	
	
	pass




func draw_circly(center, radius, color, thickness):
    var pointsPV = PoolVector2Array()

    for i in range(361):
        var angle_pointC = i * 360 / 181 + 90
        var point = center + Vector2(cos(deg2rad(angle_pointC)), sin(deg2rad(angle_pointC))) * radius
        pointsPV.push_back(point)

    for index_point in range(360):
        draw_polyline(pointsPV, color, thickness, true);
    pass



func div_circumference_in_sgmnts(nbOfSegments, center, radius):
    var pointsPS = PoolVector2Array()

    for i in range(nbOfSegments+1):
        var angle_pointS = i * 360 / nbOfSegments - 90
        var point = center + Vector2(cos(deg2rad(angle_pointS)), sin(deg2rad(angle_pointS))) * radius
        pointsPS.push_back(point)
    
    
    return pointsPS;

    pass


func draw_epicicles (nbOfEpicycles, nbOfSegments, listOfPositionsOfSegments, color, thickness):
    
    var Position1 = Vector2();
    var Position2 = Vector2();
    var Times = nbOfEpicycles + 1;
    var i = 0;
    var n = 0;
    var t = 0;
    
    for i in range (nbOfSegments):

        Position1 = listOfPositionsOfSegments[i];

        n = floor(i*Times/nbOfSegments);

        if ((i*Times)>nbOfSegments):
            t = i * Times - nbOfSegments * n;
            
        else:
            t = i * Times

        Position2 = listOfPositionsOfSegments[t];

        
        
        
        
        draw_line(Position1, Position2, color, thickness, false);
        
    

    pass


func _process(delta):
	
	if (global.ColorL.r8 != 255 && global.instruction == "redpp"):
		
		global.ColorL.r8 += 5
		
		global.comp = global.ColorL.r8 + 5
		
		if (global.comp > 250):
			
			global.ColorL.r8 = 255
			
		
	elif (global.ColorL.r8 == 255):
		
		global.instruction = "greenmm"
		
	elif (global.ColorL.g8 != 0 && global.instruction == "greenmm"):
		
		global.ColorL.g8 -= 5
		global.comp = global.ColorL.g8 -5
		
		if (global.comp < 5):
			
			global.ColorL.g8 = 0
			
		
		
	elif (global.ColorL.g8 == 0):
		
		global.instruction = "bluepp"
		
	elif (global.ColorL.b8 != 255 && global.instruction == "bluepp"):
		
		global.ColorL.b8 += 5
		
		if ((global.ColorL.b8 + 5) > 250):
			
			global.ColorL.b8 = 255
			
		
		
	elif (global.ColorL.b8 == 255):
		
		global.instruction = "redmm"
		
	elif (global.ColorL.r8 != 0 && global.instruction == "redmm"):
		
		global.ColorL.r8 -= 5
		
		if ((global.ColorL.r8 - 5) < 5):
			
			global.ColorL.r8 = 0
			
		
	elif (global.ColorL.r8 == 0):
		
		global.instruction = "greenpp"
		
	elif (global.ColorL.g8 != 255 && global.instruction == "greenpp"):
		
		global.ColorL.g8 += 5
		
		if ((global.ColorL.g8 - 5) > 250):
			
			global.ColorL.g8 = 255
			
		
	elif (global.ColorL.g8 == 255):
		
		global.instruction == "bluemm"
		
	elif (global.ColorL.b8 != 0 && global.instruction == "bluemm"):
		
		global.ColorL.b8 -= 5
		
		if ((global.ColorL.b8 - 5) < 5):
			
			global.ColorL.b8 = 0
			
		
	elif (global.ColorL.b8 == 0):
		
		global.instruction = "redpp"
		
	
	global.NbOfEpcs += global.Rate_of_Change
	update()
	
	pass

