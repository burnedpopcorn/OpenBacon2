if (global.escape)
{
    if (panicstart == false)
    {
        panicstart = true;
        fmod_event_play(escape);
        fmod_event_stop(global.music, true);
    }
    else
    {
        var s = 0;
        
        if (global.lap)
            s = 2;
        
        fmod_event_setParameter(escape, "state", s, false);
    }
}
else
{
    panicstart = false;
    fmod_event_stop(escape, true);
}
