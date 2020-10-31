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

function view_get_xview(i) {
	return camera_get_view_x(view_camera[i]);
}
function view_get_yview(i) {
	return camera_get_view_y(view_camera[i]);
}
function view_get_wview(i) {
	return camera_get_view_width(view_camera[i]);
}
function view_get_hview(i) {
	return camera_get_view_height(view_camera[i]);
}

global.sfmt_buf = buffer_create(1024, buffer_grow, 1);
global.sfmt_map = ds_map_create();
global.sfmt_warn = ds_map_create();
function sfmt() {
	var f = argument[0];
	var w = global.sfmt_map[?f], i, n;
	if (w == undefined) {
	    w[0] = "";
	    global.sfmt_map[?f] = w;
	    i = string_pos("%", f);
	    n = 0;
	    while (i) {
	        w[n++] = string_copy(f, 1, i - 1);
	        f = string_delete(f, 1, i);
	        i = string_pos("%", f);
	    }
	    w[n++] = f;
	} else n = array_length_1d(w);
	//
	var b = global.sfmt_buf;
	buffer_seek(b, buffer_seek_start, 0);
	buffer_write(b, buffer_text, w[0]);
	if (n != argument_count) {
	    f = argument[0];
	    if (!ds_map_exists(global.sfmt_warn, f)) {
	        global.sfmt_warn[?f] = true;
	        show_error("sfmt: argument count mismatch for " + f
	            + "(using " + string(n - 1) + ", got " + string(argument_count - 1) + ")", false);
	    }
	    return "";
	}
	for (i = 1; i < n; i++) {
	    f = string(argument[i]);
	    if (f != "") buffer_write(b, buffer_text, f);
	    f = w[i];
	    if (f != "") buffer_write(b, buffer_text, f);
	}
	buffer_write(b, buffer_u8, 0);
	buffer_seek(b, buffer_seek_start, 0);
	return buffer_read(b, buffer_string);
}