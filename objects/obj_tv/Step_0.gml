if (room == rm_init || room == rank_room || room == hub_hallway)
    visible = false;
else
    visible = true;

image_speed = 0.35;
var p = obj_player;
idle = 0;

if (global.combo >= 3)
    idle = 3;

if (global.escape)
    idle = 4;

switch (state)
{
    case drawing.state_1:
        drawingalpha = approach(drawingalpha, 1, 0.25);
        switchhandY = approach(switchhandY, -192, 20);
        
        switch (drawingindex)
        {
            case 4:
                if (!global.escape)
                {
                    todrawingindex = idle;
                    switchstate = 0;
                    state = drawing.state_2;
                }
                
                if (p.state == states.mach3)
                {
                    todrawingindex = 1;
                    switchstate = 0;
                    state = drawing.state_2;
                }
                
                break;
            
            case 3:
                if (global.combo < 3)
                {
                    todrawingindex = idle;
                    switchstate = 0;
                    state = drawing.state_2;
                }
            
            case 0:
                if (p.state == states.mach3)
                {
                    todrawingindex = 1;
                    switchstate = 0;
                    state = drawing.state_2;
                }
                
                if (global.escape)
                {
                    todrawingindex = idle;
                    switchstate = 0;
                    state = drawing.state_2;
                }
                
                break;
            
            case 1:
                if (p.state != states.mach3)
                {
                    todrawingindex = idle;
                    switchstate = 0;
                    state = drawing.state_2;
                }
                
                if (p.mach4)
                {
                    todrawingindex = 2;
                    switchstate = 0;
                    state = drawing.state_2;
                }
                
                break;
            
            case 2:
                if (p.state != states.mach3)
                {
                    todrawingindex = idle;
                    switchstate = 0;
                    state = drawing.state_2;
                }
                
                if (!p.mach4)
                {
                    todrawingindex = 1;
                    switchstate = 0;
                    state = drawing.state_2;
                }
                
                break;
        }
        
        break;
    
    case drawing.state_2:
        switch (switchstate)
        {
            case 0:
                switchhandY = approach(switchhandY, -76, 15);
                
                if (switchhandY >= -76)
                {
                    switchtimer = 15;
                    switchstate++;
                }
                
                break;
            
            case 1:
                drawingalpha = approach(drawingalpha, 0, 0.25);
                switchtimer--;
                
                if (switchtimer <= 0)
                {
                    switchstate++;
                    drawingindex = todrawingindex;
                    state = drawing.state_1;
                }
                
                break;
        }
}

switch (combopart)
{
    case 0:
        comboY = approach(comboY, -84, 5) + irandom_range(comboshake, -comboshake);
        combovsp = 0;
        
        if (global.combo > 0)
        {
            combopart++;
            combovsp = 5;
        }
        
        break;
    
    case 1:
        comboY = approach(comboY, 234, combovsp);
        combovsp += 0.5;
        
        if (comboY >= 230)
            combopart++;
        
        break;
    
    case 2:
        comboY = lerp(comboY, 224 + wave(-2, 2, 4, 0), 0.1) + irandom_range(comboshake, -comboshake);
        
        if (global.combo <= 0)
            combopart = 0;
        
        break;
}

milkindex += 0.35;
combopalindex = approach(combopalindex, !global.combodropped, 0.011904761904761904);
comboX = 832 + wave(-2, 2, 2, 0) + irandom_range(comboshake, -comboshake);
milkpos = lerp(milkpos, (60 * (60 - global.combotime)) / 60, 0.4);

if (global.combotime < 30)
    comboshake = (8 * (30 - global.combotime)) / 30;
else
    comboshake = 0;

if (global.escape)
{
    global.fill[2]--;
    
    if (global.fill[2] <= 0)
    {
        global.fill[2] = 60;
        global.fill[1]--;
    }
    
    if (global.fill[1] < 0 && global.fill[0] != 0)
    {
        global.fill[1] = 59;
        global.fill[0]--;
    }
    
    global.fill[1] = clamp(global.fill[1], 0, 60);
    global.fill[0] = clamp(global.fill[0], 0, 59);
    
    if (global.fill[1] <= 0 && global.fill[0] <= 0 && !instance_exists(obj_pizzaface))
        instance_create_depth(obj_player.x, obj_player.y, 1, obj_pizzaface);
}
