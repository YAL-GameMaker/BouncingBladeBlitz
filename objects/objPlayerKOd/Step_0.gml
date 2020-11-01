var vx = vel * ax;
var vy = vel * ay;
vel = max(vel - 0.1, 0);

if (vel <= 0) {
	if (objControl.coopMode && instance_number(objPlayer) > 0) {
		// wait till everyone's dead
	} else if (--timer <= 0) {
		with (objPlayer) {
			objControl.wins[player_index]++;
		}
		room_restart();
	}
} else if (position_meeting(x + vx, y + vy, objFloor)) {
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
}