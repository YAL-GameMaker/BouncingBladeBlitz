//if (live_call()) exit;
var accel = 1.5;
var dx, dy, dz;
if (player_index == 0) {
	dx = (keyboard_check(ord("D")) - keyboard_check(ord("A")));
	dy = (keyboard_check(ord("S")) - keyboard_check(ord("W")));
	dz = keyboard_check_pressed(vk_space)
} else {
	dx = (keyboard_check(vk_right) - keyboard_check(vk_left));
	dy = (keyboard_check(vk_down) - keyboard_check(vk_up));
	dz = 0;
}

if (point_length(dx, dy) > 1) {
	dx /= sqrt(2);
	dy /= sqrt(2);
}
xspeed += dx * accel;
yspeed += dy * accel;

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
	dm = max(dd - cfrict, 0) / dd;
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

if (player_index == 0) {
	weapon_angle = point_direction(x, y, mouse_x, mouse_y);
}

//
if (weapon_cool > 0) {
	if (--weapon_cool <= 0) {
		weapon_flip_cool = 1;
	}
}
else if (player_index == 0 && mouse_check_button_pressed(mb_left)) {
	weapon_cool = 30;
	weapon_flip *= -1;
	weapon_flip_cool = -1;
	var slash = instance_create_layer(x, y, "Projectiles", objSlash);
	slash.direction = weapon_angle;
	slash.speed = 2;
	slash.image_angle = weapon_angle;
	weapon_post(-4, 12, 1);
}

//
if (z <= 0) {
	if (dz) zspeed = 3;
} else {
	zspeed -= 0.25;
}
if (zspeed != 0 || z > 0) {
	z += zspeed;
	if (z < 0) { z = 0; zspeed = 0; }
}