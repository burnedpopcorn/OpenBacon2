if (global.escape)
{
    if (panicstart == false)
    {
        panicstart = true;
        scr_music(SIGMASIGMAONTHEWALL);
        audio_stop_sound(global.music);
    }
    else
    {
		// lap 2
        if (global.lap)
		{
			if (audio_is_playing(SIGMASIGMAONTHEWALL))
				audio_stop_sound(SIGMASIGMAONTHEWALL);
			if (!audio_is_playing(DINGDINGDINGDINGWAKETHEFUCKUP))
				scr_music(DINGDINGDINGDINGWAKETHEFUCKUP);
		}
    }
}
else
{
    panicstart = false;
	if (audio_is_playing(SIGMASIGMAONTHEWALL))
		audio_stop_sound(SIGMASIGMAONTHEWALL);
		
	if (audio_is_playing(DINGDINGDINGDINGWAKETHEFUCKUP))
		audio_stop_sound(DINGDINGDINGDINGWAKETHEFUCKUP);
}
