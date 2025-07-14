scr_tufekinput();
global.gameframe_caption_text = "Game Adventure New bacon2";

ini_open("options.ini");

if !audio_group_is_loaded(audiogroup_mus)
    audio_group_load(audiogroup_mus);
if !audio_group_is_loaded(audiogroup_sfx)
    audio_group_load(audiogroup_sfx);

global.MasterVolume = ini_read_real("General", "Master", 1);
global.MusicVolume = ini_read_real("General", "Music", 1);
global.SfxVolume = ini_read_real("General", "Sfx", 0.7);

audio_group_set_gain(audiogroup_mus, global.MusicVolume, 0);
audio_group_set_gain(audiogroup_sfx, global.SfxVolume, 0);

global.Fullscreen = ini_read_real("General", "Fullscreen", false);
window_set_fullscreen(global.Fullscreen);
global.Vsync = ini_read_real("General", "Vsync", false);
ini_close();
