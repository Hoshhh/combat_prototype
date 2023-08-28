event_inherited();
state = enemyStates.wander;

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

moveX = 0;
moveY = 0;
xTo = xstart;
yTo = ystart;
dir = 0;
time_passed = 0;
wait_duration = 60;
wait = 0;
aggro_check = 0;
aggro_check_duration = 5;
state_target = state;
state_previous = state;
state_wait = 0;
state_wait_duration = 0;

//Attacking
attack_timer = 30;

//Enemy sprite
spr_move = spr_enemy;
spr_attack = spr_enemy;
spr_die = spr_enemy;
spr_hurt = spr_enemy;

enemyStates_array[enemyStates.idle] = enemy_state_idle;
enemyStates_array[enemyStates.wander] = enemy_state_wander;
enemyStates_array[enemyStates.chase] = enemy_state_chase;
enemyStates_array[enemyStates.knockback] = enemy_state_knockback;
enemyStates_array[enemyStates.attack] = enemy_state_attack;
enemyStates_array[enemyStates.hurt] = enemy_state_hurt;
enemyStates_array[enemyStates.die] = enemy_state_die;
enemyStates_array[enemyStates.wait] = enemy_state_wait;