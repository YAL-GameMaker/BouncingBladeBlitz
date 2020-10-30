globalvar input_kind, input_index;
input_kind = [-1, -1];
input_index = [-1, -1];
input_kind = [0, 1];
input_index = [0, 0];

enum input {
	walk_x,
	walk_y,
	aim_x,
	aim_y,
	aim_dir,
	hit,
	jump,
	back,
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
				return gamepad_button_check_pressed(_index, gp_face2)
					|| gamepad_button_check_pressed(_index, gp_select);
			}
			break;
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
				return gamepad_axis_value(_index, gp_axislh);
			}
			break;
		case input.walk_y:
			if (_kind == 0) {
				return keyboard_check(_index * 256 + ord("S"))
					-  keyboard_check(_index * 256 + ord("W"));
			} else if (_kind == 1) {
				return gamepad_axis_value(_index, gp_axislv);
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