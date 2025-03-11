function fmod_soundeffect(snd)
{
    return event_play_oneshot(snd);
}

function fmod_soundeffect_3d(_x, _y, sound)
{
    var snd = event_play_oneshot(sound);
    fmod_event_set3DPosition(snd, _x, _y, 0);
}
