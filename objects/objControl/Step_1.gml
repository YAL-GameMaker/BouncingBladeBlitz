input_step();
if (os_browser != browser_not_a_browser) {
	var bw = 480;
	var bh = 270;
	var dw = display_get_width();
	var dh = display_get_height();
	var z = max(1, floor(min(dw / bw, dh / bh)));
	var sw = z * bw;
	var sh = z * bh;
	var sx = (dw - sw) div 2;
	var sy = (dh - sh) div 2;
	var cp = window_get_x() != sx || window_get_y() != sy;
	var cs = window_get_width() != sw || window_get_height() != sh;
	if (cp && cs) {
		window_set_rectangle(sx, sy, sw, sh);
	} else if (cp) {
		window_set_position(sx, sy);
	} else if (cs) {
		window_set_size(sw, sh);
	}
	//
	var sf = application_surface;
	if (surface_get_width(sf) != sw || surface_get_height(sf) != sh) {
		surface_resize(sf, sw, sh);
	}
}