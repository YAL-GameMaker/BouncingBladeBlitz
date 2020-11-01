is_input = input_kind[0] < 0;
mainMenu = new Menu([
	new MenuButton("Play", function() {
		levelSelect.sync();
		menu = playMenu;
	}),
	new MenuButton("Options", function() {
		
	}),
	new MenuBack(function() {
		is_input = true;
	}),
]);
noMain = true;
//
levelSelect = new LevelSelect();
//
coopToggle = new MenuButton("Coop mode: " + onoff(objControl.coopMode), function() {
	objControl.coopMode = !objControl.coopMode;
	coopToggle.label = "Coop mode: " + onoff(objControl.coopMode);
});
playMenu = new Menu([
	levelSelect,
	new MenuButton("Start", function() {
		with (objMenu.levelSelect) objControl.gotoLevel(rooms[index]);
	}),
	coopToggle,
	new MenuBack(function() {
		if (noMain) {
			is_input = true;
		} else menu = mainMenu;
	}),
]);
if (noMain) {
	if (!is_input) levelSelect.sync();
	menu = playMenu;
} else menu = mainMenu;