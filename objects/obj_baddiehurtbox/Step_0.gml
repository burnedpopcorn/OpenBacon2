if (instance_exists(baddieID))
{
    x = baddieID.x;
    y = baddieID.y;
    image_xscale = baddieID.xscale;
}
else
    instance_destroy();
