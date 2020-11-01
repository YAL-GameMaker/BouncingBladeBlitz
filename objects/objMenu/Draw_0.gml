var vc = view_camera[0];
var vw = camera_get_view_width(vc);
var vh = camera_get_view_height(vc);
draw_set_font(fntCredits);
draw_set_color(-1);
draw_set_alpha(0.3);
draw_text(4, 4, "Game by YellowAfterlife"
	+ "\nFor Disc Room Game Jam"
);
draw_set_alpha(1);
draw_set_font(fntMenu);
if (is_input) {
	InputMenu();
	exit;
}
coopToggle.visible = input_count_active() > 1; 
var h = menu.measure();
menu.draw(vw div 2, (vh - h) div 2);
menu.input(vw div 2, (vh - h) div 2);