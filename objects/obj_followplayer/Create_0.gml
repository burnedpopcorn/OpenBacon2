lag = 20;
followqueue = ds_queue_create();
targetfollower = obj_player;
gx = x;
gy = y;
ds_list_add(global.followerlist, id);
pos = ds_list_find_index(global.followerlist, id) + 1;
