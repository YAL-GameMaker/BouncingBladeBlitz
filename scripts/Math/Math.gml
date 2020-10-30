function Math() {}

function trace() {
	/// @param ...
	gml_pragma(@'global', @'
	global.trace_buf = buffer_create(1024, buffer_grow, 1);
	');
	var b = global.trace_buf;
	buffer_seek(b, buffer_seek_start, 0);
	for (var i = 0; i < argument_count; i++) {
		if (i) buffer_write(b, buffer_u8, ord(" "));
		trace_1(b, argument[i], 0);
	}
	buffer_write(b, buffer_u8, 0);
	buffer_seek(b, buffer_seek_start, 0);
	var s = buffer_read(b, buffer_string);
	show_debug_message(s);
}
function trace_1(b, v, d) {
	var i, n;
	if (is_array(v)) {
		if (d > 8) {
			buffer_write(b, buffer_text, "[...]");
		} else if (array_height_2d(v) > 1) {
			buffer_write(b, buffer_text, string(v));
		} else {
			buffer_write(b, buffer_u8, ord("["));
			n = array_length_1d(v);
			for (i = 0; i < n; i++) {
				if (i) buffer_write(b, buffer_text, ", ");
				trace_1(b, v[i], d);
			}
			buffer_write(b, buffer_u8, ord("]"));
		}
	} else if (is_string(v)) {
		buffer_write(b, buffer_u8, ord(@'`'));
		buffer_write(b, buffer_text, string(v));
		buffer_write(b, buffer_u8, ord(@'`'));
	} else {
		buffer_write(b, buffer_text, string(v));
	}
}

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