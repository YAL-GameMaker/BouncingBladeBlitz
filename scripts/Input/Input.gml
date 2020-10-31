#macro maxplayers 2
globalvar input_kind, input_index;
input_kind = array_create(maxplayers, -1);
input_index = array_create(maxplayers, -1);
//input_kind = [0, 1]; input_index = [0, 0];

globalvar gamepad_axis_lval_x0, gamepad_axis_lval_x1, gamepad_axis_lval_y0, gamepad_axis_lval_y1;
gamepad_axis_lval_x0 = array_create(maxplayers, 0);
gamepad_axis_lval_y0 = array_create(maxplayers, 0);
gamepad_axis_lval_x1 = array_create(maxplayers, 0);
gamepad_axis_lval_y1 = array_create(maxplayers, 0);

function input_step() {
	for (var p = 0; p < maxplayers; p++) {
		if (input_kind[p] == 1) {
			gamepad_axis_lval_x0[p] = gamepad_axis_lval_x1[p];
			gamepad_axis_lval_y0[p] = gamepad_axis_lval_y1[p];
			gamepad_axis_lval_x1[p] = gamepad_axis_value(input_index[p], gp_axislh);
			gamepad_axis_lval_y1[p] = gamepad_axis_value(input_index[p], gp_axislv);
			//trace(gamepad_axis_lval_x0, gamepad_axis_lval_x1);
			//trace(gamepad_axis_lval_y0, gamepad_axis_lval_y1);
		} else {
			gamepad_axis_lval_x0[p] = 0;
			gamepad_axis_lval_y0[p] = 0;
			gamepad_axis_lval_x1[p] = 0;
			gamepad_axis_lval_y1[p] = 0;
		}
	}
}

function input_count_active() {
	var n = 0;
	for (var i = 0; i < maxplayers; i++) {
		if (input_kind[i] >= 0) n++;
	}
	return n;
}

enum input {
	walk_x,
	walk_y,
	aim_x,
	aim_y,
	aim_dir,
	hit,
	jump,
	// menu-specific:
	left, right, up, down,
	back,
	accept,
}
function input_check(_plr, _btn) {
	var _kind = input_kind[_plr];
	var _index = input_index[_plr];
	switch (_btn) {
		case input.hit:
			if (_kind == 0) {
				return device_mouse_check_button(_index, mb_left);
			} else if (_kind == 1) {
				return gamepad_button_check(_index, gp_face3)
					|| gamepad_button_check(_index, gp_shoulderrb);
			}
			break;
		case input.jump:
			if (_kind == 0) {
				return keyboard_check(_index * 256 + vk_space);
			} else if (_kind == 1) {
				return gamepad_button_check(_index, gp_face1)
					|| gamepad_button_check(_index, gp_shoulderlb);
			}
			break;
	}
	return false;
}
function input_pressed(_plr, _btn) {
	var _kind = input_kind[_plr];
	var _index = input_index[_plr];
	switch (_btn) {
		case input.hit:
			if (_kind == 0) {
				return device_mouse_check_button_pressed(_index, mb_left);
			} else if (_kind == 1) {
				return gamepad_button_check_pressed(_index, gp_face3)
					|| gamepad_button_check_pressed(_index, gp_shoulderrb);
			}
			break;
		case input.jump:
			if (_kind == 0) {
				return keyboard_check_pressed(_index * 256 + vk_space);
			} else if (_kind == 1) {
				return gamepad_button_check_pressed(_index, gp_face1)
					|| gamepad_button_check_pressed(_index, gp_shoulderlb);
			}
			break;
		case input.back:
			if (_kind == 0) {
				return keyboard_check_pressed(_index * 256 + vk_escape);
			} else if (_kind == 1) {
				return gamepad_button_check_pressed(_index, gp_face2) && !instance_exists(objLevel)
					|| gamepad_button_check_pressed(_index, gp_select);
			}
			break;
		case input.accept:
			if (_kind == 0) {
				return keyboard_check_pressed(_index * 256 + vk_enter);
			} else if (_kind == 1) {
				return gamepad_button_check_pressed(_index, gp_face1)
					|| gamepad_button_check_pressed(_index, gp_start);
			}
			break;
		case input.left:
			if (_kind == 0) {
				return keyboard_check_pressed(_index * 256 + vk_left);
			} else if (_kind == 1) {
				return gamepad_button_check_pressed(_index, gp_padl)
					|| gamepad_axis_lval_x0[_plr] >= -0.5 && gamepad_axis_lval_x1[_plr] < -0.5;
			}
			break;
		case input.right:
			if (_kind == 0) {
				return keyboard_check_pressed(_index * 256 + vk_right);
			} else if (_kind == 1) {
				return gamepad_button_check_pressed(_index, gp_padr)
					|| gamepad_axis_lval_x0[_plr] <= 0.5 && gamepad_axis_lval_x1[_plr] > 0.5;
			}
			break;
		case input.up:
			if (_kind == 0) {
				return keyboard_check_pressed(_index * 256 + vk_up);
			} else if (_kind == 1) {
				return gamepad_button_check_pressed(_index, gp_padu)
					|| gamepad_axis_lval_y0[_plr] >= -0.5 && gamepad_axis_lval_y1[_plr] < -0.5;
			}
			break;
		case input.down:
			if (_kind == 0) {
				return keyboard_check_pressed(_index * 256 + vk_down);
			} else if (_kind == 1) {
				return gamepad_button_check_pressed(_index, gp_padd)
					|| gamepad_axis_lval_y0[_plr] <= 0.5 && gamepad_axis_lval_y1[_plr] > 0.5;
			}
			break;
	}
	return false;
}
function input_pressed_any(_btn) {
	for (var p = 0; p < maxplayers; p++) {
		if (input_kind[p] >= 0 && input_pressed(p, _btn)) return true;
	}
	return false;
}
function input_axis(_plr, _axis) {
	var _kind = input_kind[_plr];
	var _index = input_index[_plr];
	switch (_axis) {
		case input.walk_x:
			if (_kind == 0) {
				return keyboard_check(_index * 256 + ord("D"))
					-  keyboard_check(_index * 256 + ord("A"));
			} else if (_kind == 1) {
				var v = gamepad_button_check(_index, gp_padr) - gamepad_button_check(_index, gp_padl);
				return v != 0 ? v : gamepad_axis_value(_index, gp_axislh);
			}
			break;
		case input.walk_y:
			if (_kind == 0) {
				return keyboard_check(_index * 256 + ord("S"))
					-  keyboard_check(_index * 256 + ord("W"));
			} else if (_kind == 1) {
				var v = gamepad_button_check(_index, gp_padd) - gamepad_button_check(_index, gp_padu);
				return v != 0 ? v : gamepad_axis_value(_index, gp_axislv);
			}
			break;
		case input.aim_x:
			if (_kind == 0) {
				return device_mouse_x(_index) - x;
			} else if (_kind == 1) {
				return gamepad_axis_value(_index, gp_axisrh);
			}
			break;
		case input.aim_y:
			if (_kind == 0) {
				return device_mouse_y(_index) - y;
			} else if (_kind == 1) {
				return gamepad_axis_value(_index, gp_axisrv);
			}
			break;
	}
	return 0;
}
function input_aimdir(_plr) {
	var ax = input_axis(_plr, input.aim_x);
	var ay = input_axis(_plr, input.aim_y);
	if (point_length(ax, ay) < 0.5 && input_kind[_plr] == 1) {
		ax = input_axis(_plr, input.walk_x);
		ay = input_axis(_plr, input.walk_y);
	}
	if (point_length(ax, ay) < 0.5) return undefined;
	return point_direction(0, 0, ax, ay);
}
function mouse_in_rect(_left_x, _top_y, _width, _height) {
	return point_in_rectangle(mouse_x, mouse_y,
		_left_x, _top_y,
		_left_x + _width, _top_y + _height
	);
}
function mouse_in_rect_xc(_top_mid_x, _top_y, _width, _height) {
	return point_in_rectangle(mouse_x, mouse_y,
		_top_mid_x - _width / 2, _top_y,
		_top_mid_x + _width / 2, _top_y + _height
	);
}