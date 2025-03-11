if (!ds_list_empty(music_details))
    for (var i = 0; i < ds_list_size(music_details); i++)
    {
        var q = ds_list_find_value(music_details, i);
        
        if (room == q.roomtoset && !event_isplaying(escape))
            if (q.music != currentmusic)
            {
                if (event_isplaying(global.music))
                {
                    fmod_event_stop(global.music, false);
                    global.music = -4;
                }
                
                global.music = event_play_oneshot(q.music);
                currentmusic = fmod_event_getEventPath(global.music);
            }
    }
