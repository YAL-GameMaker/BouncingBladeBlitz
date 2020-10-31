if (!position_meeting(x, y - 2, objFloor)) {
	dir = 0;
} else if (!position_meeting(x, y + 2, objFloor)) {
	dir = 180;
} else if (!position_meeting(x - 2, y, objFloor)) {
	dir = 90;
} else dir = 270;