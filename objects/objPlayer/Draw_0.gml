var has_weapon = true;
var wep_iter = lengthdir_y(1, weapon_angle) < 0 ? -1 : 0;

repeat (1 + has_weapon) {
    if (wep_iter == 0) {
        var qs = sprite_index;
        var qi = image_index;
        var qb = image_blend;
        if (jump_cool > 0 && z <= 0) qb = c_menugray;
        if (qs != -1) draw_sprite_ext(qs, qi, x, y - z,
            image_xscale * facing, image_yscale,
            image_angle, qb, image_alpha);
    } else {
        var cwep_angle = weapon_angle;
        var cwep_yscale = dcos(weapon_angle) < 0 ? -1 : 1;
        if (true) {
            cwep_angle += weapon_flip * 120 * (1 - weapon_kick / 20);
            cwep_yscale = weapon_flip_cool * weapon_flip;
        }
        draw_sprite_ext(sprHammer, 0,
            x + lengthdir_x(-weapon_kick, cwep_angle),
            y - 4 - z + lengthdir_y(-weapon_kick, cwep_angle),
            1, cwep_yscale,
            cwep_angle, image_blend, image_alpha);
    }
    wep_iter += 1;
}