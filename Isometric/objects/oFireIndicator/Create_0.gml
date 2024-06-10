/// @description Insert description here
// You can write your code in this editor

thousandsplace = instance_create_layer(x - 36, y, "GUI", oRollingMeter)
hundredsplace = instance_create_layer(x + 6, y, "GUI", oRollingMeter)
tensplace = instance_create_layer(x +48, y, "GUI", oRollingMeter)
onesplace = instance_create_layer(x +90, y, "GUI", oRollingMeter)

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