if (timestop) exit;
var vx = vel * ax;
var vy = vel * ay;
var ox = x, oy = y;

if (position_meeting(x + vx, y + vy, objFloor)) {
	x += vx;
	y += vy;
} else {
	var vd = 0;
	repeat (vel) {
		if (!position_meeting(x + ax, y + ay, objFloor)) break;
		x += ax;
		y += ay;
		vd += 1;
	}
	vx = ax * (vel - vd);
	vy = ay * (vel - vd);
	addTrail(ox, oy, x + ax, y + ay);
	ox = x + ax;
	oy = y + ay;
	//
	if (position_meeting(x - vx, y + vy, objFloor)) {
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
	//
	screen_shake_at(x, y, min(vel, 4));
	image_xscale = 1 + (vel - 0.5) * 0.1;
	image_angle = point_direction(0, 0, ax, ay);
	//
	if (1) { // doesn't really fit if we're being honest
		var snd = choose(DR_SFX_DiscBounce1, DR_SFX_DiscBounce2, DR_SFX_DiscBounce3, DR_SFX_DiscBounce4);
		var au = audio_play_sound(snd, 0, 0);
		audio_sound_gain(au, 0.1, 0);
		audio_sound_pitch(au, 1.5);
	}
}
addTrail(ox, oy, x, y);