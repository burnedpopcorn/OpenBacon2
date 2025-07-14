global.collect += 100;
global.combotime = 60;
randomize();
create_collect(sprite_index, x, y);
ds_list_add(global.saveroom, id);
instance_destroy();
scr_soundeffect_3d(sfx_kaching, x, y);
scr_soundeffect_3d(choose(sfx_riff1, sfx_riff2), x, y);
