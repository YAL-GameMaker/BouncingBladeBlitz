var tm = layer_tilemap_get_id("FloorTiles");
for (var _x = 0; _x < room_width; _x += 32)
for (var _y = 0; _y < room_height; _y += 32) {
	var t = tilemap_get_at_pixel(tm, _x + 16, _y + 16);
	if (t == 1) instance_create_layer(_x, _y, "Floors", objFloor);
}
with (objFloor) {
	for (var _x = x - 32; _x < x + 64; _x += 16)
	for (var _y = y - 32; _y < y + 64; _y += 16)
	if ((_x < x || _x >= x + 32)
	 && (_y < y || _y >= y + 32)
	 && !position_meeting(_x + 8, _y + 8, objFloor)
	 && !position_meeting(_x + 8, _y + 8, objWall)
	) {
		instance_create_layer(_x, _y, "Floors", objWall);
	}
}
