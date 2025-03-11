if (image_alpha == 1)
{
    global.collect += 100;
    global.combotime = 60;
    create_collect(sprite_index, x, y);
    ds_list_add(global.escaperoom, id);
    instance_destroy();
}
