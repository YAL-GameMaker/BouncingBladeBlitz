globalvar gmt_active, gmt_delay, gmt_count, timestop;
timestop = false;
var inf = os_get_info();
gmt_active = ds_map_exists(inf, "gmt:net_index");
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