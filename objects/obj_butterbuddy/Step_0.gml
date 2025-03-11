active = place_meeting(x, y, obj_player);

if (active)
{
    if (sprite_index != spr_talk)
    {
        sprite_index = spr_talk;
        image_index = 0;
    }
    
    switch (borderpart)
    {
        case 0:
            borderY = approach(borderY, 43, borderVsp);
            borderVsp += 0.5;
            
            if (borderY >= 43)
                borderpart++;
            
            break;
        
        case 1:
            borderY = lerp(borderY, 32 + wave(-2, 2, 8, 0), 0.15);
            break;
    }
}
else
{
    borderpart = 0;
    borderVsp = 0;
    borderY = approach(borderY, borderTargetpos, 5);
    sprite_index = spr_idle;
}

borderX = 32 + wave(-2, 2, 4, 0);
