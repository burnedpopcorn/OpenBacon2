enum drawing
{
	state_1,
	state_2
}

state = drawing.state_1;
expressiontimer = 0;
switchstate = 0;
switchtimer = 0;
drawingalpha = 1;
todrawingindex = 0;
idle = 0;
sprite_index = spr_tv_idle;
drawingindex = 0;
switchhandY = -192;
comboX = 832;
comboY = -64;
combovsp = 0;
combopart = 0;
milkpos = 0;
milkindex = 0;
comboshake = 0;
combopalindex = !global.combodropped;
surf = surface_create(278, 139);
clip = surface_create(278, 139);
