depth = 1;
fadeAlpha = 0;
part = 0;
obj_player.state = states.actor;
obj_camera.lock = true;
instance_destroy(obj_pizzaface);
global.escape = false;
audio_stop_sound(global.music);

// old rank code
rankmusic = scr_soundeffect_2d(gateslam);//scr_soundeffect_2d(mu_rankPLACEHOLDER);
shownrank = false;
rankindex = 0;
layer_enable_fx("Effect_1", false);
