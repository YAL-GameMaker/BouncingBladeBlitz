var vc = view_camera[0];
var xnext = x - camera_get_view_width(vc) / 2;
var ynext = y - camera_get_view_height(vc) / 2;
xview = lerp(xview, xnext, 0.4);
yview = lerp(yview, ynext, 0.4);
//
var vx = xview + random_range(-0.5, 0.5) * screenshake;
var vy = yview + random_range(-0.5, 0.5) * screenshake;
camera_set_view_pos(vc, vx, vy);

if (screenshake > 10) screenshake *= 0.8;
screenshake = max(screenshake - 1, 0);