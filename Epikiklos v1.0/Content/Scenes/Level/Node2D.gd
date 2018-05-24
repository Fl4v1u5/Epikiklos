extends Node



func _draw():
	
	var center = Vector2(320, 240)
	
	var NbOfSegments = 100
	
	if (global.NbOfSgmnts > 0):
		
		 NbOfSegments = global.NbOfSgmnts;
		
	
	var ColorC = global.ColorC
	
	var ColorL = global.ColoL
	
	
	var radius;
	
	if (global.RadiusC > 0):
		
		radius = global.RadiusC;
		
	
	
	var listPositionOfSegments = div_circumference_in_sgmnts(NbOfSegments, center, radius);
	
	var NbOfEpicicles = 1;
	
	if (global.NbOfEpcs > 0):
		
		NbOfEpicicles = global.NbOfEpcs;
		
	
	var Thickness = 3;
	
	if ( global.thicc > 0):
		
		Thickness = global.thicc;
		
	
	draw_circly(center, radius, ColorC, Thickness)
	
	draw_epicicles(NbOfEpicicles, NbOfSegments, listPositionOfSegments, ColorL, Thickness);
	
	
	
	
	
	pass




func draw_circly(center, radius, color, thickness):
    var pointsPV = PoolVector2Array()

    for i in range(181):
        var angle_pointC = i * 360 / + 90
        var point = center + Vector2(cos(deg2rad(angle_pointC)), sin(deg2rad(angle_pointC))) * radius
        pointsPV.push_back(point)

    for index_point in range(180):
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
    #var Times = 1.1
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


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

