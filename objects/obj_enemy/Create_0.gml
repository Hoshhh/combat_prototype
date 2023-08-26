event_inherited();

x_prev = x;
y_prev = y;

x_contact = 0;
y_contact = 0;

knockback_speed = 2.0;
knockback_distance = 32;
knockback_height = 16;
move_distance_remaining = 0;
hit_timer = 80;

z = 0;



enum enemyStates {
	free,
	knockback,
	attack,
}

state = enemyStates.free;
enemyStates_array[enemyStates.free] = enemy_state_free;
enemyStates_array[enemyStates.knockback] = enemy_state_knockback;
enemyStates_array[enemyStates.attack] = enemy_state_attack;