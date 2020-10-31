function Math() {}

function orf(a, b) {
	return a ? a : b;
}

function point_length(_x, _y) {
	return point_distance(0, 0, _x, _y);
}
function approach(v, t, d) {
	return v + clamp(t - v, -d, d);
}
function cycle(a, b, c) {
	var offset = argument1;
	var value = argument0 - offset;
	var range = argument2 - offset;
	value = value mod range;
	if (value < 0) value += range;
	return value + offset;
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

function array_find_index(arr, val){
	var i = array_length(arr);
	while (--i >= 0) if (arr[i] == val) return i;
	return -1;
}