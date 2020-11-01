if (instance_exists(objLevel)) {
	draw_set_font(fntScore);
	draw_set_color(c_white);
	var p = 5;
	with (objDisc) other.discVel = vel;
	var w = display_get_gui_width();
	var showWins = input_count_active() > 1 && !coopMode;
	if (showWins) {
		draw_set_halign(0);
		draw_text_shadow(p, p, string(wins[0]));
	}
	draw_set_halign(1);
	draw_text_shadow(w/2, p, string(round(scoreDisplayMultiplier*discVel)));
	if (showWins) {
		draw_set_halign(2);
		draw_text_shadow(w - p, p, string(wins[1]));
	}
if (instance_exists(objPlayerKOd) && !instance_exists(objPlayer)) {
	draw_set_font(fntScore);
	draw_set_color(c_white);
	draw_set_halign(1);
	draw_set_valign(1);
	var w = display_get_gui_width();
	var h = display_get_gui_height();
	var txt;
	if (array_find_index(input_kind, 0) >= 0) {
		if (array_find_index(input_kind, 1) >= 0) {
			txt = "[Esc] or [Back/Select]";
		} else txt = "[Esc]";
	} else if (array_find_index(input_kind, 1) >= 0) {
		txt = "[Back/Select]";
	} else txt = "";
	draw_text_shadow(w div 2, h div 2, sfmt("% to exit",txt));
	draw_set_halign(0);
	draw_set_valign(0);
}