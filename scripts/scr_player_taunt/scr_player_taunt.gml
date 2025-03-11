function scr_player_taunt()
{
    hsp = 0;
    vsp = 0;
    tauntTimer--;
    
    if (tauntTimer <= 0)
    {
        state = tauntsavedState;
        sprite_index = tauntsavedSprite;
        image_index = tauntsavedIndex;
        image_speed = tauntsavedSpeed;
        movespeed = tauntsavedMovespeed;
        vsp = tauntsavedVsp;
    }
}
