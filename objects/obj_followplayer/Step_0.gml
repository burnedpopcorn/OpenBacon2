var xx = obj_player.x;
var yy = obj_player.y;
var xscale = obj_player.xscale;
ds_queue_enqueue(followqueue, xx);
ds_queue_enqueue(followqueue, yy);
ds_queue_enqueue(followqueue, xscale);

if (ds_queue_size(followqueue) > (lag * pos))
{
    gx = ds_queue_dequeue(followqueue);
    gy = ds_queue_dequeue(followqueue);
    image_xscale = ds_queue_dequeue(followqueue);
}

x = approach(x, gx - (25 * image_xscale * pos), 16);
y = approach(y, gy, 16);

if (ds_list_find_index(global.followerlist, id) == -1)
    instance_destroy();
