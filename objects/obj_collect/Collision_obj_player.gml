global.collect += 10;
global.combotime += 10;
global.combotime = clamp(global.combotime, 0, 60);
create_collect(sprite_index, x, y);
ds_list_add(global.saveroom, id);
scr_soundeffect_3d(sfx_collect, x, y);
instance_destroy();
