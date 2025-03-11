switch (part)
{
    case 0:
        titlexscale = approach(titlexscale, 1, 0.2);
        titleyscale = approach(titleyscale, 1, 0.04);
        
        if (titlexscale == 1 && titleyscale == 1 && titlealpha == 1)
        {
            part++;
            goawaytimer = 120;
        }
        
        break;
    
    case 1:
        goawaytimer = approach(goawaytimer, 0, 1);
        
        if (goawaytimer == 0)
            part++;
        
        break;
    
    case 2:
        titlexscale = approach(titlexscale, 5, 1/3);
        titleyscale = approach(titleyscale, 5, 1/3);
        titlealpha = approach(titlealpha, 0, 0.18);
        
        if (titlealpha == 0)
            instance_destroy();
        
        break;
}
