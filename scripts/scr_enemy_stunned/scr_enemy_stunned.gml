function scr_enemy_stunned()
{
    if (grounded)
        movespeed = approach(movespeed, 0, 1);
    
    hsp = movespeed;
    
    if (scaredtimer <= 0)
    {
        state = baddiestates.move;
        sprite_index = spr_walk;
    }
    else
        scaredtimer--;
}
