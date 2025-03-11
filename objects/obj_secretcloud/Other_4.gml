if (ds_list_find_index(global.saveroom, id) != -1)
{
    instance_destroy();
    instance_create_depth(x, y, depth, obj_secretcloud_enter);
}
