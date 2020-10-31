// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function vel_move_bounce() {
	if (vel <= 0) return false;
	var vx = vel * ax;
	var vy = vel * ay;
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
		return true;
	}
	return false;
}