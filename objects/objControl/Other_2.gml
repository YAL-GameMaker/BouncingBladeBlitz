roomsToCap = tag_get_asset_ids("level", asset_room);
for (var i = 0; i < array_length(roomsToCap); i++) {
	var rm = roomsToCap[i];
	if (asset_has_tags(rm, "1p", asset_room)) array_push(roomsPerPlayerCount[1], rm);
	if (asset_has_tags(rm, "2p", asset_room)) array_push(roomsPerPlayerCount[2], rm);
}
roomCapInd = 0;
timestop = true;
room_goto(roomsToCap[roomCapInd++]);