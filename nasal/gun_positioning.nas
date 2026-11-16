print("MODULE(gun) loaded");

# sim/model/turret-positions/turretx : -110 to 110
# sim/model/turret-positions/turretz : -60 to 0


props.globals.initNode("controls/armament/gun-control",1,"INT");
props.globals.initNode("controls/armament/gun-heading",0,"DOUBLE");
props.globals.initNode("controls/armament/gun-pitch",0,"DOUBLE");

var internal = 0;
setlistener("sim/current-view/view-number", func {
    print("MODULE(gun) View changed");
	internal = getprop("sim/current-view/internal");
}, 1);
print("MODULE(gun) View listener installed");

# Gun =============================================================
var gunposition = func {

	var sel = getprop("/controls/armament/gun-control");
	var gundirection = 0.0;
	var gunheight = 0.0;
	var viewheading = getprop("/sim/current-view/goal-heading-offset-deg");
	var viewpitch = getprop("/sim/current-view/goal-pitch-offset-deg");

	if (sel == 1 and internal == 1) {
		gundirection = (360 - viewheading);

        if (gundirection > 0 and gundirection < 180){
            if(gundirection > 110){gundirection = 110;}
        }else if (gundirection >= 180 and gundirection <= 360){
            if(gundirection < (360-110)){gundirection = (360-110);}
        }
        
        gundirection = gundirection * -1;
		# setprop("controls/armament/gun-heading", gundirection);
		# sim/model/turret-positions/turretx
        setprop("sim/multiplay/generic/float[5]", gundirection);

		gunheight = viewpitch;
		if (gunheight > 0) { gunheight = 0; };
		if (gunheight < -60) { gunheight = -60; };
		# setprop("controls/armament/gun-pitch", gunheight);

		#  sim/model/turret-positions/turretz
        setprop("sim/multiplay/generic/float[4]", gunheight);

        # print("MODULE(gun) Direction and Elevation changed");
	}
	if (sel != 1) {
		setprop("controls/armament/gun-heading", 0);	
		setprop("controls/armament/gun-pitch", 10);	
	}

	settimer(gunposition, 0.05);
}




setlistener("/sim/signals/fdm-initialized", func {
    gun.gunposition();
    print("MODULE(gun) gun.gunpositioning called");
});
