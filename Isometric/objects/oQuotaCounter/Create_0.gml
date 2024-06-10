/// @description Insert description here
// You can write your code in this editor

// population
ponesplace = instance_create_layer(x +60, y- 66, "GUI", oRollingMeter)
ptensplace = instance_create_layer(x + 18, y- 66, "GUI", oRollingMeter)
phundredsplace = instance_create_layer(x - 24, y- 66, "GUI", oRollingMeter)
pthousandsplace = instance_create_layer(x - 66, y- 66, "GUI", oRollingMeter)

ponesplace.depth = depth-1
ptensplace.depth = depth-1
phundredsplace.depth = depth-1
pthousandsplace.depth = depth-1

ponesplace.image_xscale = image_xscale
ptensplace.image_xscale = image_xscale
phundredsplace.image_xscale = image_xscale
pthousandsplace.image_xscale = image_xscale

ponesplace.image_yscale = image_yscale
ptensplace.image_yscale = image_yscale
phundredsplace.image_yscale = image_yscale
pthousandsplace.image_yscale = image_yscale

// deadline
donesplace = instance_create_layer(x +60, y + 120, "GUI", oRollingMeter)
dtensplace = instance_create_layer(x + 18, y+ 120, "GUI", oRollingMeter)
dhundredsplace = instance_create_layer(x - 24, y+ 120, "GUI", oRollingMeter)
dthousandsplace = instance_create_layer(x - 66, y+ 120, "GUI", oRollingMeter)

donesplace.depth = depth-1
dtensplace.depth = depth-1
dhundredsplace.depth = depth-1
dthousandsplace.depth = depth-1

donesplace.image_xscale = image_xscale
dtensplace.image_xscale = image_xscale
dhundredsplace.image_xscale = image_xscale
dthousandsplace.image_xscale = image_xscale

donesplace.image_yscale = image_yscale
dtensplace.image_yscale = image_yscale
dhundredsplace.image_yscale = image_yscale
dthousandsplace.image_yscale = image_yscale