var a = 90;
image_angle = a;
ax = lengthdir_x(1, a);
ay = lengthdir_y(1, a);
vel = 0.5;
function addTrail(x1, y1, x2, y2) {
	var t = instance_create_layer(x1, y1, "WallBots", objTrail);
	t.image_angle = point_direction(x1, y1, x2, y2);
	t.image_xscale = point_distance(x1, y1, x2, y2) / 4;
}