if (roomCapInd != -1) {
	var sf = application_surface;
	var w = surface_get_width(sf);
	var h = surface_get_height(sf);
	//
	var w1 = 480;
	var h1 = 270;
	var s1 = surface_create(w1, h1);
	surface_set_target(s1);
	draw_clear(c_white);
	gpu_set_colorwriteenable(1,1,1,0);
	gpu_set_texfilter(1);
	draw_surface_stretched(sf, 0, 0, w1, h1);
	gpu_set_texfilter(0);
	gpu_set_colorwriteenable(1,1,1,1);
	surface_reset_target();
	roomSprites[?room] = sprite_create_from_surface(s1, 0, 0, w1, h1, 0, 0, 0, 0);
	surface_free(s1);
	//
	var name = room_get_name(room);
	roomNames[?room] = string_delete(name, 1, 2);
	//
	if (roomCapInd < array_length(roomsToCap)) {
		room_goto(roomsToCap[roomCapInd++]);
	} else {
		roomCapInd = -1;
		timestop = false;
		room_goto(rmMenu);
	}
}