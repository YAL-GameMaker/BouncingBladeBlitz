if (player_index == 0) {
	spr_idle = sprBanditIdle;
	spr_walk = sprBanditWalk;
} else {
	spr_idle = sprTallBanditIdle;
	spr_walk = sprTallBanditWalk;
}
xspeed = 0;
yspeed = 0;
maxspeed = 3;
cfrict = 0.225;
facing = 1;
weapon_angle = 0;
weapon_kick = 0;
weapon_flip = 1;
weapon_flip_cool = 1;
weapon_cool = 0;
z = 0;
zspeed = 0;