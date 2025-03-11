bgalpha = 1 - (distance_to_object(obj_player) / visibleradius);

if (distance_to_object(obj_player) == 0)
    drawing = 1;
else
    drawing = 0;

if (drawing)
    textalpha += 0.015;
else
    textalpha -= 0.015;

textalpha = clamp(textalpha, 0, 1);
