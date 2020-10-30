var floorBelow = place_meeting(x, y + 1, objFloor);
if (floorBelow) instance_create_layer(x, y, "WallBots", objWallBot);
var topBot = floorBelow || place_meeting(x, y + 17, objFloor);
instance_create_layer(x, y - 8, topBot ? "WallBots2" : "WallTops", objWallTop);