global.collect += 100;
global.combotime = 60;
randomize();
create_collect(sprite_index, x, y);
ds_list_add(global.saveroom, id);
instance_destroy();
fmod_soundeffect_3d(x, y, "event:/Sfx/collect2");
fmod_soundeffect_3d(x, y, "event:/Sfx/bigcollect");
