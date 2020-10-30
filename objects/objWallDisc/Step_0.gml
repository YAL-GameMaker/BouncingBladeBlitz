var sv = sign(vel) * 2;
switch (dir) {
	case 0: {
		if (position_meeting(x + vel, y + sv, objFloor)) {
			x += vel;
		} else if (position_meeting(x - sv, y + vel, objFloor)) {
			y += vel;
			dir = 270;
		}
	}; break;
	case 90: {
		if (position_meeting(x + sv, y - vel, objFloor)) {
			y -= vel;
		} else if (position_meeting(x + vel, y + sv, objFloor)) {
			x += vel;
			dir = 0;
		}
	}; break;
	case 180: {
		if (position_meeting(x - vel, y - sv, objFloor)) {
			x -= vel;
		} else if (position_meeting(x + sv, y - vel, objFloor)) {
			y -= vel;
			dir = 90;
		}
	}; break;
	case 270: {
		if (position_meeting(x - sv, y + vel, objFloor)) {
			y += vel;
		} else if (position_meeting(x - vel, y - sv, objFloor)) {
			x -= vel;
			dir = 180;
		}
	}; break;
}
image_angle += 45;