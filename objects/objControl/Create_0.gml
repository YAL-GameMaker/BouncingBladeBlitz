globalvar gmt_active, gmt_index, gmt_delay, gmt_count, timestop;
timestop = false;
var inf = os_get_info();
gmt_active = ds_map_exists(inf, "gmt:net_index");
gmt_index = orf(inf[?"gmt:net_index"], 0);
if (gmt_active) {
	debug_event("gmt:multidevice");
}
gmt_delay = orf(inf[?"gmt:net_delay"], 0);
gmt_count = orf(inf[?"gmt:net_count"], 0);
ds_map_destroy(inf);
roomCapInd = -1;
roomSprites = ds_map_create();
roomNames = ds_map_create();
roomsPerPlayerCount = [[], [], []];
lastGameRoom = -1;
randomize();
display_set_gui_size(480, 270);
wins = [0, 0];
discVel = 0;
function gotoLevel(rm) {
	wins = [0, 0];
	discVel = 0;
	room_goto(rm);
}

#region scores
scoresPerRoomPath = "scores.json";
var f = file_text_open_read(scoresPerRoomPath);
if (f >= 0) {
	var json_str = file_text_read_string(f);
	scoresPerRoom = json_str != "" ? json_decode(json_str) : -1;
	file_text_close(f);
} else scoresPerRoom = -1;
if (scoresPerRoom == -1) scoresPerRoom = ds_map_create();
function updateScoreForCurrentRoom() {
	var rs = room_get_name(room);
	var cur = orf(scoresPerRoom[?rs], 0);
	//trace("best?", discVel, cur);
	if (discVel > cur) {
		scoresPerRoom[?rs] = discVel;
		var f = file_text_open_write(scoresPerRoomPath);
		if (f >= 0) {
			file_text_write_string(f, json_encode(scoresPerRoom))
			file_text_close(f);
		}
	}
}
scoreDisplayMultiplier = 2;
#endregion