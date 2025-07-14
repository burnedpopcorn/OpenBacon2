function set_audio_gain(snd, vol = global.MusicVolume)
{
    audio_sound_gain(snd, audio_sound_get_gain(snd) * vol, 0);
}

function scr_music(snd)
{
    var _gain = audio_play_sound(snd, 0, true);
    set_audio_gain(_gain, audio_sound_get_gain(snd) * global.MusicVolume);
    return _gain;
}

function scr_soundeffect_2d(snd, pitch = 0, looping = false)
{
    var _s = audio_play_sound(snd, 0, looping);
    audio_sound_pitch(_s, 1 + pitch);
    set_audio_gain(_s, audio_sound_get_gain(snd) * global.SfxVolume);
    return _s;
}

function scr_soundeffect_3d(snd, _x, _y, pitch = 0, looping = false)
{
    var _s = audio_play_sound_at(snd, -_x, _y, 0, 960, 960 * 5, 3, looping, 0);
    audio_sound_pitch(_s, 1 + pitch);
    set_audio_gain(_s, audio_sound_get_gain(snd) * global.SfxVolume);
    return _s;
}
