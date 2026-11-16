

# Gun =============================================================
var gunposition = func {

	var sel = getprop("/sim/current-view/view-number");
	var gundirection = 0;
	var gunheight = 0;
	var viewheading = getprop("/sim/current-view/goal-heading-offset-deg");
	var viewpitch = getprop("/sim/current-view/goal-pitch-offset-deg");

	if (sel == 9) {
		gundirection = (360 - viewheading);
		setprop("systems/gun-heading", gundirection);
		gunheight = viewpitch;
		if (gunheight > 10) { gunheight = 10; };
		if (gunheight < -50) { gunheight = -50; };
		setprop("systems/gun-pitch", gunheight);
	}
	if (sel != 1) {
		setprop("systems/gun-heading", 0);	
		setprop("systems/gun-pitch", 10);	
	}

	settimer(gunposition, 0.05);
}

settimer(gunposition, 0.05);


