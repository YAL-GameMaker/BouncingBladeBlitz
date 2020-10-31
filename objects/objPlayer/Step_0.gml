if (timestop) exit;
var accel = 1.5, dd;
var dx = input_axis(player_index, input.walk_x);
var dy = input_axis(player_index, input.walk_y);
var dz = input_pressed(player_index, input.jump);

var dd = point_length(dx, dy);
if (dd > 1) {
	dx /= dd;
	dy /= dd;
}
if (dd > 0.5) {
	xspeed += dx * accel;
	yspeed += dy * accel;
}

//
var dd = point_length(xspeed, yspeed);
var dm = 1;
if (dd > maxspeed) {
	dm = maxspeed / dd;
}
xspeed *= dm;
yspeed *= dm;

//
dd = point_length(xspeed, yspeed);
if (dd > 0) {
	dm = max(dd - (z > 0 ? africt : cfrict), 0) / dd;
}
xspeed *= dm;
yspeed *= dm;

//
facing = dcos(weapon_angle) > 0 ? 1 : -1;
weapon_kick = approach(weapon_kick, 0, 0.5);

//
dd = point_length(xspeed, yspeed);
if (dd > 0.5) {
	sprite_index = spr_walk;
} else {
	sprite_index = spr_idle;
}

//
if (xspeed != 0 && place_meeting(x + xspeed, y, objSolid)) {
	var sx = sign(xspeed);
	repeat (abs(xspeed)) {
		if (place_meeting(x + sx, y, objSolid)) break;
		x += sx;
	}
	xspeed = 0;
} else x += xspeed;
if (yspeed != 0 && place_meeting(x, y + yspeed, objSolid)) {
	var sy = sign(yspeed);
	repeat (abs(yspeed)) {
		if (place_meeting(x, y + sy, objSolid)) break;
		y += sy;
	}
	yspeed = 0;
} else y += yspeed;

var dir = input_aimdir(player_index);
if (dir != undefined) weapon_angle = dir;

//
if (weapon_cool > 0) {
	if (--weapon_cool <= 0) {
		weapon_flip_cool = 1;
	}
}
else if (input_pressed(player_index, input.hit)
	&& (z <= 0 || zspeed < 0)
) {
	weapon_cool = 30;
	weapon_flip *= -1;
	weapon_flip_cool = -1;
	//
	var au = audio_play_sound(DR_SFX_CINEMATIC_KIK1a, 1, 0);
	audio_sound_pitch(au, random_range(0.9, 1.1));
	//
	var slash = instance_create_layer(x, y, "Projectiles", objSlash);
	slash.player_index = player_index;
	slash.direction = weapon_angle;
	slash.speed = 2;
	slash.image_angle = weapon_angle;
	weapon_post(-4, 12, 1);
}

//
if (z <= 0) {
	if (jump_cool > 0) {
		jump_cool -= 1;
	} else {
		if (dz) {
			zspeed = 3;
			jump_cool = 30;
		}
	}
} else {
	zspeed -= 0.25;
}
if (zspeed != 0 || z > 0) {
	z += zspeed;
	if (z < 0) { z = 0; zspeed = 0; }
}
if (input_pressed(player_index, input.back)) {
	lastGameRoom = room;
	room_goto(rmMenu);
}