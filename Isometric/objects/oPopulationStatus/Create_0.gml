/// @description Insert description here
// You can write your code in this editor


onesplace = instance_create_layer(x + 54, y + 72, "GUI", oRollingMeter)
tensplace = instance_create_layer(x + 12, y + 72, "GUI", oRollingMeter)
hundredsplace = instance_create_layer(x - 30, y + 72, "GUI", oRollingMeter)
thousandsplace = instance_create_layer(x - 72, y + 72, "GUI", oRollingMeter)

onesplace.depth = depth-1
tensplace.depth = depth-1
hundredsplace.depth = depth-1
thousandsplace.depth = depth-1

onesplace.image_xscale = image_xscale
tensplace.image_xscale = image_xscale
hundredsplace.image_xscale = image_xscale
thousandsplace.image_xscale = image_xscale

onesplace.image_yscale = image_yscale
tensplace.image_yscale = image_yscale
hundredsplace.image_yscale = image_yscale
thousandsplace.image_yscale = image_yscale