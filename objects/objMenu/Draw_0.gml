draw_set_font(fntMenu);
var vc = view_camera[0];
var vw = camera_get_view_width(vc);
var vh = camera_get_view_height(vc);
if (is_input) {
	var _w = 320;
	var _h = 80;
	var _p = 10;
	var _x = (vw - _w) div 2;
	var _y = (vh - _h * maxplayers - _p * (maxplayers - 1)) div 2;
	var canstart = input_kind[0] >= 0;
	var only2p = true;
	for (var p = 0; p < maxplayers; p++) {
		if (input_kind[p] < 0) {
			var i, k;
			//
			var n = gmt_count + 1;
			for (i = 0; i < n; i++) {
				for (k = 0; k < maxplayers; k++) {
					if (input_kind[k] == 0 && input_index[k] == i) break;
				}
				if (k < maxplayers) continue;
				//
				if (keyboard_check_pressed(256 * i + vk_enter)) {
					input_kind[p] = 0;
					input_index[p] = i;
					break;
				}
			}
			if (i < n) break;
			//
			for (i = 0; i < 12; i++) {
				for (k = 0; k < maxplayers; k++) {
					if (input_kind[k] == 1 && input_index[k] == i) break;
				}
				if (k < maxplayers) continue;
				//
				if (gamepad_button_check(i, gp_start)) {
					input_kind[p] = 1;
					input_index[p] = i;
					break;
				}
			}
			if (i < n) break;
		} else {
			if (input_pressed(p, input.back)) {
				input_kind[p] = -1;
				input_index[p] = -1;
				if (p == 0 || only2p) canstart = false;
				break;
			}
			if (input_pressed(p, input.accept)) {
				is_input = false;
				levelSelect.sync();
			}
		}
	}
	canstart = input_kind[0] >= 0;
	var nop1 = (only2p
		? "\nNeed two players to start."
		: "\nCan't start with P1 not assigned."
	);
	for (var p = 0; p < maxplayers; p++) {
		draw_rectangle_px(_x, _y, _x + _w, _y + _h, 0, 0, input_kind[p] >= 0 ? 0.5 : 0.2);
		draw_rectangle_px(_x, _y, _x + _w, _y + _h, 1, -1);
		var s; switch (input_kind[p]) {
			case 0:
				s = "Keyboard";
				if (input_index[p] > 0) s += " " + string(input_index[p]);
				s += canstart ? "\nEnter to start" : nop1;
				s += "\nEsc to unassign";
				break;
			case 1:
				s = "Gamepad " + string(input_index[p]);
				s += canstart ? "\nStart/A/Button1 to start" : nop1;
				s += "\nBack/select to unassign";
				break;
			default:
				s = "Empty";
				s += "\nEnter (keyboard) or\nStart (gamepad) to assign";
		}
		draw_text_shadow(_x + 4, _y + 4, "Player " + string(p + 1) + ": " + s);
		_y += _h + _p;
	}
	exit;
}
var h = menu.measure();
menu.draw(vw div 2, (vh - h) div 2);
menu.input(vw div 2, (vh - h) div 2);