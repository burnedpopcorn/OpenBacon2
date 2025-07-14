fadeAlpha = approach(fadeAlpha, 1, 0.1);

with (obj_player)
{
    image_speed = 0.35;
    var targetx = (960 / 2) + camera_get_view_x(view_camera[0]);
    var targety = (540 / 2) + camera_get_view_y(view_camera[0]);
    x = approach(x, targetx, 1);
    y = approach(y, targety, 1);
    
    if (animation_end())
        image_speed = 0;
}

switch (part)
{
    case 0:
        if (fadeAlpha == 1)
        {
            camera_set_view_pos(view_camera[0], 0, 0);
            part++;
            room = rank_room;
        }
        
        break;
    
    case 1:
        if (!shownrank && audio_sound_get_track_position(rankmusic) >= 9)
        {
            shownrank = true;
            rankindex = 0;
            obj_player.visible = false;
        }
        else
        {
            rankindex += 0.45;
            rankindex = clamp(rankindex, 0, sprite_get_number(spr_rankPLACEHOLDER) - 1);
        }
        
        if (!audio_is_playing(rankmusic))
            event_user(0);
        
        break;
}
