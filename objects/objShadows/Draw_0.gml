var sw = surface_get_width(application_surface);
var sh = surface_get_height(application_surface);
if (!surface_exists(surf)) {
	surf = surface_create(sw, sh);
} else if (surface_get_width(surf) != sw || surface_get_height(surf) != sh) {
	surface_resize(surf, sw, sh);
}
//
surface_set_target(surf);
draw_clear_alpha(0, 0);
var vc = view_camera[0];
var vx = camera_get_view_x(vc);
var vy = camera_get_view_y(vc);
with (objPlayer) draw_sprite(sprShadow24, 0, x-vx, y-vy);
with (objDisc) {
	//draw_sprite(sprShadow16, 0, x-vx, y-vy + 4);
	draw_sprite_ext(sprite_index, image_index,
		x-vx, y-vy + 4, image_xscale, image_yscale*0.7,
		image_angle, c_black, image_alpha
	);
}
surface_reset_target();
//
draw_surface_stretched_ext(surf, vx, vy, sw, sh, -1, 0.7);
