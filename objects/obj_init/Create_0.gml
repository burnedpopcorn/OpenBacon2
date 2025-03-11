scr_tufekinput();
ini_open("options.ini");
global.MasterVolume = ini_read_real("General", "Master", 1);
global.MusicVolume = ini_read_real("General", "Music", 1);
global.SfxVolume = ini_read_real("General", "Sfx", 0.7);
global.Fullscreen = ini_read_real("General", "Fullscreen", false);
window_set_fullscreen(global.Fullscreen);
global.Vsync = ini_read_real("General", "Vsync", false);
ini_close();
