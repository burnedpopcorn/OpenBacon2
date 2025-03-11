part = 0;
obj_player.state = states.actor;
obj_camera.lock = true;
instance_destroy(obj_pizzaface);
global.escape = false;
parttimer = 300;
fakevsp = 0;
fakehsp = 0;
audio_stop_sound(global.music);
