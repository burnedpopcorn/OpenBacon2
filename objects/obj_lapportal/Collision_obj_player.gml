if (cutscene == false && global.escape)
{
    cutscene = true;
    part = 0;
    other.sprite_index = spr_player_Sjumpcancelstart;
    other.image_index = 0;
    other.state = states.actor;
}
