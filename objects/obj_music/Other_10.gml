if (!ds_list_empty(music_details))
{
    for (var i = 0; i < ds_list_size(music_details); i++)
    {
        var q = ds_list_find_value(music_details, i);
		
		var escapeplaying = audio_is_playing(SIGMASIGMAONTHEWALL) || audio_is_playing(DINGDINGDINGDINGWAKETHEFUCKUP)
        
        if (room == q.roomtoset && !escapeplaying)
		{
            if (q.music != currentmusic && !audio_is_playing(q.music))
            {
                if (audio_is_playing(global.music))
                {
                    audio_stop_sound(global.music);
                    global.music = -4;
                }
                
                global.music = scr_music(q.music);
                currentmusic = global.music;
            }
		}
    }
}