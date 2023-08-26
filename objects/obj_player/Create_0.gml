w_spd = 1;
n_spd = 1.25;
r_spd = 2;
spd = n_spd;

mx = 0;
my = 0;

//Dashing
is_dashing = false;
dash_duration = 15;
dash_cooldown = 60;
input_direction = 0;
input_magnitude = 0;

//Attacking
hit_by_attack = -1;
attack_timer = 30;

enum states {
	free,
	dash,
	attack,
}

state = states.free;
states_array[states.free] = player_state_free;
states_array[states.dash] = player_state_dash;
states_array[states.attack] = player_state_attack;
