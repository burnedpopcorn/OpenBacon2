if (fadein == true)
{
    fadeAlpha = approach(fadeAlpha, 1, 0.1);
    
    if (fadeAlpha == 1)
    {
        fadein = false;
        room = targetRoom;
    }
}
else
{
    fadeAlpha = approach(fadeAlpha, 0, 0.1);
    
    if (fadeAlpha == 0)
        instance_destroy();
}
