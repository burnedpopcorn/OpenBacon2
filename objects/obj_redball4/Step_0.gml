scr_collision();

if (vsp >= 10)
    vsp += grav;

if (hitstuntimer <= 0)
{
    image_speed = 0.35;
    event_inherited();
    stunbuffer = approach(stunbuffer, 0, 1);
    
    switch (state)
    {
        case baddiestates.thrown:
            scr_enemy_thrown();
            break;
        
        case baddiestates.grabbed:
            scr_enemy_grabbed();
            break;
        
        case baddiestates.move:
            scr_enemy_move();
            break;
        
        case baddiestates.scared:
            scr_enemy_scared();
            break;
        
        case baddiestates.stunned:
            scr_enemy_stunned();
            break;
        
        case baddiestates.hit:
            scr_enemy_hit();
            break;
    }
}
else if (hitstuntimer > 0)
{
    image_speed = 0;
    x = hitX + irandom_range(-1, 1);
    y = hitY + irandom_range(-1, 1);
    hitstuntimer--;
}
else if (hitstuntimer <= 0)
{
    x = hitX;
    y = hitY;
}
