#macro c_menugray 0xC9CACC
function MenuItem() constructor {
	selectable = true;
	static measure = function() { return 0; }
	static draw = function(_menu) {}
	static input = function(_menu) {}
}

function Menu(_items) constructor {
	items = _items;
	index = 0;
	pad = 10;
	static draw = function(_x, _y) {
		x = _x;
		y = _y;
		var n = array_length(items)
		for (var i = 0; i < n; i++) {
			selected = i == index;
			items[i].draw(self);
		}
	}
	static measure = function() {
		var h = 0;
		var n = array_length(items)
		for (var i = 0; i < n; i++) {
			h += items[i].measure(self);
		}
		return h;
	}
	static input = function(_x, _y) {
		var n = array_length(items)
		//
		var d = input_pressed_any(input.down) - input_pressed_any(input.up);
		if (d != 0) repeat (n) {
			index = (index + d) % n;
			if (index < 0) index += n;
			if (items[index].selectable) break;
		}
		//
		x = _x;
		y = _y;
		for (var i = 0; i < n; i++) {
			selected = i == index;
			var _val = items[i].input(self);
			if (_val) break;
		}
	}
}

function MenuButton(_label, _func) : MenuItem() constructor {
	label = _label;
	func = _func;
	xpad = 4;
	static measure = function(_menu) {
		return string_height(label);
	}
	static draw = function(_menu) {
		var w = string_width(label) + xpad;
		var h = string_height(label);
		if (mouse_in_rect_xc(_menu.x, _menu.y, w, h)) {
			draw_rect_px_xc(_menu.x, _menu.y, w, h, 0, 0, 0.3)
		}
		draw_set_halign(1);
		draw_set_color(_menu.selected ? c_white : c_menugray);
		draw_text_shadow(_menu.x, _menu.y, label);
		_menu.y += string_height(label) + _menu.pad;
	}
	static input = function(_menu) {
		var w = string_width(label) + xpad;
		var h = string_height(label);
		if (_menu.selected && input_pressed_any(input.accept)
			|| mouse_check_button_pressed(mb_left) && mouse_in_rect_xc(_menu.x, _menu.y, w, h)
		) {
			func();
			return true;
		}
		_menu.y += h + _menu.pad;
	}
}

function MenuBack(_func) : MenuItem() constructor {
	func = _func;
	label = "Back";
	selectable = false;
	xpad = 4;
	static draw = function(_menu) {
		if (array_find_index(input_kind, 0)) {
			if (array_find_index(input_kind, 1)) {
				label = "[<,Esc] Back";
			} else label = "[Esc] Back";
		} else {
			if (array_find_index(input_kind, 1)) {
				label = "[<] Back";
			} else label = "Back";
		}
		var w = string_width(label) + xpad;
		var h = string_height(label);
		var _x = view_get_wview(0) - w - 4;
		var _y = view_get_hview(0) - h - 4;
		draw_set_halign(0);
		draw_set_color(c_menugray);
		if (mouse_in_rect(_x, _y, w, h)) {
			draw_rect_px(_x, _y, w, h, 0, 0, 0.3);
		}
		draw_text_shadow(_x + xpad div 2, _y, label);
	}
	static input = function(_menu) {
		var w = string_width(label) + xpad;
		var h = string_height(label);
		var _x = view_get_wview(0) - w - 4;
		var _y = view_get_hview(0) - h - 4;
		if (input_pressed_any(input.back)
			|| mouse_check_button_pressed(mb_left) && mouse_in_rect(_x, _y, w, h)
		) {
			func();
			return true;
		}
	}
}