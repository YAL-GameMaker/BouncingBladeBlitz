if (instance_exists(objLevel)) {
	draw_set_font(fntScore);
	draw_set_color(c_white);
	var p = 5;
	with (objDisc) other.discVel = vel;
	var w = display_get_gui_width();
	draw_set_halign(0);
	draw_text_shadow(p, p, string(wins[0]));
	draw_set_halign(1);
	draw_text_shadow(w/2, p, string(round(2*discVel)));
	draw_set_halign(2);
	draw_text_shadow(w - p, p, string(wins[1]));
	draw_set_halign(0);
}