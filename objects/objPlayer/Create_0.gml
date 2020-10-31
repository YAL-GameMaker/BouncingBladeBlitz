if (player_index == 0) {
	spr_idle = sprBanditIdle;
	spr_walk = sprBanditWalk;
	facing = 1;
	weapon_angle = 0;
} else {
	spr_idle = sprTallBanditIdle;
	spr_walk = sprTallBanditWalk;
	facing = -1;
	weapon_angle = 180;
}
xspeed = 0;
yspeed = 0;
maxspeed = 3;
cfrict = 0.225;
weapon_kick = 0;
weapon_flip = 1;
weapon_flip_cool = 1;
weapon_cool = 0;
z = 0;
zspeed = 0;