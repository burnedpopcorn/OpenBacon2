if (obj_player.state != states.taunt)
    instance_destroy();

if (animation_end())
    image_speed = 0;
