//if (live_call()) exit;
var vx = vel * ax;
var vy = vel * ay;
var ox = x, oy = y;

var bounced = true;
if (position_meeting(x + vx, y + vy, objFloor)) {
	x += vx;
	y += vy;
	bounced = false;
} else if (position_meeting(x - vx, y + vy, objFloor)) {
	ax *= -1;
	x -= vx;
	y += vy;
} else if (position_meeting(x + vx, y - vy, objFloor)) {
	ay *= -1;
	x += vx;
	y -= vy;
} else {
	ax *= -1;
	ay *= -1;
	x -= vx;
	y -= vy;
}
if (bounced) {
	screen_shake_at(x, y, min(vel, 4));
	image_xscale = 1 + (vel - 0.5) * 0.1;
	image_angle = point_direction(0, 0, ax, ay);
	var onx = lerp(ox + vx, x - vx, 0.5);
	var ony = lerp(oy + vy, y - vy, 0.5);
	addTrail(ox, oy, onx, ony);
	ox = onx;
	oy = ony;
}
addTrail(ox, oy, x, y);