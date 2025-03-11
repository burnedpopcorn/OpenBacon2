if (image_alpha == 1)
{
    global.collect += 10;
    global.combotime += 10;
    global.combotime = clamp(global.combotime, 0, 60);
    create_collect(sprite_index, x, y);
    ds_list_add(global.saveroom, id);
    instance_destroy();
}
