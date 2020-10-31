/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param outline
/// @param [color]
/// @param [alpha]
function draw_rectangle_px(x1, y1, x2, y2, outline, color, alpha) {
	if (color == undefined) color = draw_get_color();
	if (alpha == undefined) alpha = draw_get_alpha();
	if (outline) {
		draw_sprite_stretched_ext(sprWhite32, 0, x1, y1, x2-x1, 1, color, alpha);
		draw_sprite_stretched_ext(sprWhite32, 0, x1, y1 + 1, 1, y2-y1-2, color, alpha);
		draw_sprite_stretched_ext(sprWhite32, 0, x2-1, y1 + 1, 1, y2-y1-2, color, alpha);
		draw_sprite_stretched_ext(sprWhite32, 0, x1, y2-1, x2-x1, 1, color, alpha);
	} else {
		draw_sprite_stretched_ext(sprWhite32, 0, x1, y1, x2-x1, y2-y1, color, alpha);
	}
}
/// @param x
/// @param y
/// @param width
/// @param height
/// @param outline
/// @param [color]
/// @param [alpha]
function draw_rect_px(_x, _y, _w, _h, outline, color, alpha) {
	draw_rectangle_px(_x, _y, _x + _w, _y + _h, outline, color, alpha);
}

/// @param x
/// @param y
/// @param width
/// @param height
/// @param outline
/// @param [color]
/// @param [alpha]
function draw_rect_px_xc(_x, _y, _w, _h, outline, color, alpha) {
	var x1 = _x - _w div 2;
	var x2 = x1 + _w;
	draw_rectangle_px(x1, _y, x2, _y + _h, outline, color, alpha);
}

function draw_text_shadow(_x, _y, _string) {
	var c = draw_get_color();
	var a = draw_get_alpha();
	draw_set_color(0);
	draw_set_alpha(a * 0.7);
	draw_text(_x + 1, _y, _string);
	draw_text(_x, _y + 1, _string);
	draw_text(_x + 1, _y + 1, _string);
	draw_set_color(c);
	draw_set_alpha(a);
	draw_text(_x, _y, _string);
}

/// Like draw_sprite_ext, but has a half-pixel offset for origin
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