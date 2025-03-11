event_inherited();
spr_intro = spr_mudcup_intro;
spr_idle = spr_mudcup_idle;
spr_walk = spr_mudcup_walk;
global.collect += 1000;
sprite_index = spr_intro;
ogx = x;
ogy = y;
depth = 1;
image_speed = 0.35;
// you should also remove this
scr_soundeffect_3d(vfx_mudcup, x, y, random(0.15));

if (chance(0.25))
    scr_soundeffect_2d(vfx_phew, random(0.15));

with (obj_tv)
{
    expressiontimer = 120;
    expressionsprite = spr_tv_happy;
    switchindex = 0;
    state = drawing.state_2;
}
