if (other.hitdisk) exit;
other.hitdisk = true;

var a = other.image_angle;
image_xscale *= 1.5;
image_angle = a;
ax = lengthdir_x(1, a);
ay = lengthdir_y(1, a);
vel += 0.5;