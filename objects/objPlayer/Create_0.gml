if (input_kind[player_index] < 0) {
	instance_destroy();
	exit;
}
if (player_index == 0) {
	spr_idle = sprBanditIdle;
	spr_walk = sprBanditWalk;
	spr_hurt = sprBanditKOd;
	facing = 1;
	weapon_angle = 0;
} else {
	spr_idle = sprTallBanditIdle;
	spr_walk = sprTallBanditWalk;
	spr_hurt = sprTallBanditKOd;
	facing = -1;
	weapon_angle = 180;
}
xspeed = 0;
yspeed = 0;
maxspeed = 3;
cfrict = 0.225;
africt = 0.150;
weapon_kick = 0;
weapon_flip = 1;
weapon_flip_cool = 1;
weapon_cool = 0;
jump_cool = 0;
z = 0;
zspeed = 0;
invulnerable = false;
function getHit(_vel, _dir) {
	if (invulnerable) return false;
	if (z > 0) return false;
	objControl.updateScoreForCurrentRoom();
	if (!objControl.coopMode) {
		with (objPlayer) if (id != other.id) invulnerable = true;
	}
	screen_shake_at(x, y, 10 + 5 * _vel);
	with (instance_create_layer(x, y, layer, objPlayerKOd)) {
		vel = _vel;
		ax = lengthdir_x(1, _dir);
		ay = lengthdir_y(1, _dir);
		sprite_index = other.spr_hurt;
		image_xscale = other.facing;
	}
	instance_destroy();
	return true;
}
function getHitBy(_who, _vel) {
	return getHit(_vel, point_direction(_who.x, _who.y, x, y));
}