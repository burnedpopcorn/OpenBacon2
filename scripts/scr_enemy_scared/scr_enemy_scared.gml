function scr_enemy_scared()
{
    hsp = movespeed * xscale;
    movespeed = 0;
    
    if (scaredtimer <= 0)
    {
        state = baddiestates.move;
        sprite_index = spr_walk;
    }
    else
        scaredtimer--;
}
