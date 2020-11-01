function LevelSelect() : MenuItem() constructor {
	width = 100;
	height = 100;
	arrWidth = 20;
	arrHeight = 20;
	arrTop = 0;
	index = 0;
	count = 1;
	lastCount = -1;
	rooms = [];
	scale = 0.5;
	static measure = function(_menu) {
		return height;
	}
	static input = function(_menu) {
		if (_menu.selected) {
			//
			var d = input_pressed_any(input.right) - input_pressed_any(input.left);
			var _x = _menu.x - width div 2;
			var _y = _menu.y;
			if (mouse_check_button_pressed(mb_left)) {
				if (mouse_in_rect(_x - arrWidth, _y + arrTop, arrWidth, arrHeight)) d = -1;
				if (mouse_in_rect(_x + width, _y + arrTop, arrWidth, arrHeight)) d = 1;
				if (mouse_in_rect(_x, _y, width, height)) {
					objControl.gotoLevel(rooms[index]);
					return true;
				}
			}
			//
			if (d != 0) {
				index = (index + d) % count;
				if (index < 0) index += count;
				return true;
			}
			//
			if (input_pressed_any(input.accept)) {
				objControl.gotoLevel(rooms[index]);
				return true;
			}
		}
		_menu.y += height + _menu.pad;
	}
	static draw = function(_menu) {
		var rm = rooms[index];
		var sp = objControl.roomSprites[?rm];
		var z = scale;
		var _x = _menu.x - width div 2;
		var _y = _menu.y;
		
		// mouseover areas:
		if (mouse_in_rect(_x, _y, width, height)) {
			draw_rect_px(_x - 1, _y - 1, width + 2, height + 2, 0, 0, 0.3);	
		}
		if (mouse_in_rect(_x - arrWidth, _y + arrTop, arrWidth, arrHeight)) {
			draw_rect_px(_x - arrWidth, _y + arrTop, arrWidth, arrHeight, 0, 0, 0.3);
		}
		if (mouse_in_rect(_x + width, _y + arrTop, arrWidth, arrHeight)) {
			draw_rect_px(_x + width, _y + arrTop, arrWidth, arrHeight, 0, 0, 0.3);
		}
		
		// arrows:
		draw_set_halign(1);
		draw_set_valign(1);
		draw_text_shadow(_x - arrWidth div 2, _y + arrTop + arrHeight div 2, "<");
		draw_text_shadow(_x + width + arrWidth div 2, _y + arrTop + arrHeight div 2, ">");
		
		// level screenshot:
		draw_sprite_ext(sp, 0, _x, _y, z, z, 0, -1, 1);
		
		// level name:
		draw_set_valign(0);
		draw_set_color(_menu.selected ? c_white : c_menugray);
		draw_text_shadow(_menu.x, _menu.y, objControl.roomNames[?rm]);
		
		// best score, if any:
		var best = objControl.scoresPerRoom[?room_get_name(rm)];
		if (best != undefined) {
			best *= objControl.scoreDisplayMultiplier;
			draw_set_valign(2);
			draw_text_shadow(_menu.x, _menu.y + height, sfmt("Best: %",best));
			draw_set_valign(0);
		}
		_menu.y += height + _menu.pad;
	}
	static sync = function() {
		var n = input_count_active();
		rooms = objControl.roomsPerPlayerCount[n];
		if (n != lastCount) {
			index = array_find_index(rooms, objControl.lastGameRoom);
			if (index < 0) index = 0;
			lastCount = n;
		}
		//
		var rm = rooms[index];
		var sp = objControl.roomSprites[?rm];
		count = array_length(rooms);
		width = sprite_get_width(sp) * scale;
		height = sprite_get_height(sp) * scale;
		arrHeight = height div 2;
		arrTop = (height - arrHeight) div 2;
	}
}