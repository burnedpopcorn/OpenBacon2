scr_collision();

if (vsp >= 10)
    vsp += 0.5;

if (flash == true && alarm[0] <= 0)
    alarm[0] = 0.15 * room_speed;

depth = 0;

if (!hitstun)
{
    scr_playerstate();
    
    if (y > (room_height + 300) && !instance_exists(obj_fuckinidiot))
        instance_create_depth(0, 0, 0, obj_fuckinidiot);
    
    if (state == states.mach3 || state == states.Sjump || state == states.freefall || state == states.punch || state == states.wallkick)
        instakillmove = true;
    else
        instakillmove = false;
    
    if (state == states.Sjumpprep || state == states.tumble || state == states.crouch)
        mask_index = spr_crouchmask;
    else
        mask_index = spr_player_mask;
    
    if (global.combo > 0 && !instance_exists(obj_fuckinidiot))
        global.combotime = approach(global.combotime, 0, 0.15);
    
    if ((global.combo % 5) == 0 && combo != global.combo)
    {
        combo = global.combo;
        instance_create_depth(0, 0, -10, obj_combotitle);
    }
    
    if (global.combotime == 0)
    {
        combo = global.combo;
        global.combo = 0;
        
        if (combo != global.combo)
        {
            global.combodropped = true;
            
            with (instance_create_depth(0, 0, -10, obj_combotitle))
                index = floor(other.combo / 5) - 1;
            
            combo = global.combo;
        }
    }
    
    slope_rotation();
    
    if (!instance_exists(chargeffect) && state == states.mach3)
    {
        chargeffect = instance_create_depth(x, y, 1, obj_chargeeffect);
        
        with (chargeffect)
            playerid = obj_player;
    }
}
else if (hitstuntimer > 0)
{
    image_speed = 0;
    
    if (!instance_exists(obj_fadeout))
    {
        x = hitX + irandom_range(-5, 5);
        y = hitY + irandom_range(-5, 5);
    }
    
    hitstuntimer--;
}
else if (hitstuntimer <= 0)
{
    hitstun = false;
    
    if (!instance_exists(obj_fadeout))
    {
        x = hitX;
        y = hitY;
    }
    
    if (place_meeting_solid(x, y))
	{
        while (place_meeting_solid(x, y))
            y--;
	}
}
