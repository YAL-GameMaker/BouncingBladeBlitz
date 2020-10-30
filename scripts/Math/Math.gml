function Math() {}

function point_length(_x, _y) {
	return point_distance(0, 0, _x, _y);
}
function approach(v, t, d) {
	return v + clamp(t - v, -d, d);
}
function screen_shake_at(_x, _y, _amt) {
	objCamera.screenshake += _amt;
}
function weapon_post(_kick, _shift, _shake) {
	weapon_kick = _kick;
	objCamera.xview += lengthdir_x(_shift, weapon_angle);
	objCamera.yview += lengthdir_y(_shift, weapon_angle);
	objCamera.screenshake += _shake;
}
function draw_sprite_ext_ho(_sprite, _subimg, _x, _y, _sx, _sy, _rot, _col, _alpha) {
	var ax = -lengthdir_x(0.5, _rot) * _sx;
	var ay = -lengthdir_y(0.5, _rot) * _sy;
	draw_sprite_ext(_sprite, _subimg,
		_x + ax + ay,
		_y + ay - ax,
		_sx, _sy, _rot, _col, _alpha
	);
}
function draw_self_ho() {
	draw_sprite_ext_ho(sprite_index, image_index, x, y,
		image_xscale, image_yscale, image_angle, image_blend, image_alpha
	);
}