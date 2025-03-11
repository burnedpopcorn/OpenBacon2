if (distance_to_object(obj_player) < 480 && visible == false && global.escape && activated == false)
{
    visible = true;
    image_index = 0;
}

if (visible == true)
{
    if (enemyinst == -4 && activated == false && floor(image_index) == 7)
    {
        activated = true;
        enemyinst = instance_create_depth(x, y, 0, content);
    }
    
    if (animation_end())
        visible = false;
}

if (enemyinst != -4 && activated == true)
{
    if (!instance_exists(enemyinst))
    {
        instance_destroy();
        ds_list_add(global.escaperoom, id);
    }
}
