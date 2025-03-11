function scr_player_hurt()
{
    image_speed = 0.35;
    
    if (grounded)
    {
        create_particle(spr_land, x, y, 1);
        
        if (move != 0)
            sprite_index = spr_player_land2;
        else
            sprite_index = spr_player_land;
        
        image_index = 0;
        state = states.normal;
    }
}
