
function enemy_state_idle(){

	//Reset move varaibles
	moveX = 0;
	moveY = 0;
	
	
	//Collision checking
	Collision();
	
	//Apply movement
	x += moveX;
	y += moveY;
	
	if (place_meeting(x,y, obj_player) && obj_player.state == states.dash) {
		state = enemyStates.knockback;
		x_prev = x;
		y_prev = y;
		x_contact = obj_player.x;
		y_contact = obj_player.y;
		move_distance_remaining = knockback_distance;
	}
	
}


function enemy_state_knockback(){
	var _dir = point_direction(x_contact, y_contact, x_prev, y_prev);
	
	moveX = lengthdir_x(2, _dir);
	moveY = lengthdir_y(2, _dir);
	
	move_distance_remaining = max(0, move_distance_remaining-knockback_speed)
			
	//Change state
	if (move_distance_remaining <= 0) {
		state = enemyStates.wander;	
	}
	
	//Change height
	z = sin(((move_distance_remaining / knockback_distance) * pi)) * knockback_height;
	
	//Check collisions
	Collision()
			
	x += moveX;
	y += moveY;
}


function enemy_state_wander(){
	sprite_index = spr_move;
	
	//At destination or given up
	if ((x == xTo) && (y == yTo)) || (time_passed > enemy_wander_distance / enemy_speed) {
		moveX = 0;
		moveY = 0;
		
		//End our move animation
		
		//Set new target destination
		if (++wait >= wait_duration) {
			wait = 0;
			time_passed = 0;
			dir = point_direction(x,y,xstart,ystart) + irandom_range(-45, 45);
			xTo = x + lengthdir_x(enemy_wander_distance, dir);
			yTo = y + lengthdir_y(enemy_wander_distance, dir);
		} 
	} else {
		//Move toward new destination
		time_passed++;
		image_speed = 1;
		var _distance_to_go = point_distance(x,y, xTo, yTo)
		var _speed_this_frame = enemy_speed;
		
		if (_distance_to_go < enemy_speed) _speed_this_frame = _distance_to_go;
		dir = point_direction(x,y,xTo,yTo);
		moveX = lengthdir_x(_speed_this_frame, dir);
		moveY = lengthdir_y(_speed_this_frame, dir);
		
		if (moveX != 0) image_xscale = sign(moveX);
		
		//Collide & Move
		enemy_collision();
		x += moveX;
		y += moveY;
		
	}
	
	//Allows enemy to be knockedback
	if (place_meeting(x,y, obj_player) && obj_player.state == states.dash) {
		state = enemyStates.knockback;
		xTo = x;
		yTo = y;
		x_prev = x;
		y_prev = y;
		x_contact = obj_player.x;
		y_contact = obj_player.y;
		move_distance_remaining = knockback_distance;
	}
	
	//Check for aggro
	if (++aggro_check >= aggro_check_duration) {
		aggro_check = 0;
		
		if (instance_exists(obj_player)) && (point_distance(x,y,obj_player.x, obj_player.y) <= enemy_aggro_radius) {
			state = enemyStates.chase;
			target = obj_player;
		}
	}
	
}


function enemy_state_chase(){
	sprite_index = spr_move
	
	if (instance_exists(target)) {
		xTo = target.x;
		yTo = target.y;
		
		var _distance_to_go = point_distance(x,y,xTo,yTo);
		image_speed = 1;
		dir = point_direction(x,y, xTo, yTo);
		
		if (_distance_to_go > enemy_speed) {
			moveX = lengthdir_x(enemy_speed, dir);
			moveY = lengthdir_y(enemy_speed, dir);
		} else {
			moveX = lengthdir_x(_distance_to_go, dir);
			moveY = lengthdir_y(_distance_to_go, dir);
		}
		
		if (moveX != 0) image_xscale = sign(moveX);
		
		//Collide & move
		enemy_collision()
		x += moveX;
		y += moveY
	}
	
	
	//If close enough to attack
	if (instance_exists(target)) && (point_distance(x, y, xTo, yTo) <= enemy_attack_radius) {
		state = enemyStates.attack;
		sprite_index = spr_attack;
		image_speed = 1;
		
		//target 8px past the player
		xTo += lengthdir_x(8, dir);
		yTo += lengthdir_y(8, dir);
		attack_timer = 30;
	}
	
	//Allows enemy to be knockedback
	if (place_meeting(x,y, obj_player) && obj_player.state == states.dash) {
		state = enemyStates.knockback;
		xTo = x;
		yTo = y;
		x_prev = x;
		y_prev = y;
		x_contact = obj_player.x;
		y_contact = obj_player.y;
		move_distance_remaining = knockback_distance;
	}
}


function enemy_state_wait(){
	if (++state_wait >= state_wait_duration) {
		state_wait = 0;
		state = state_target;
	}
}


function enemy_state_attack(){
	//Temp melee
	if (!instance_exists(obj_enemy_hitbox) and instance_exists(obj_player)) {
		attack_timer--;
		
		var dist = 2
		var xx = x + lengthdir_x(dist, dir);
		var yy = (y-8) + lengthdir_y(dist, dir);

		// Create slash
		if (attack_timer == 8) {
			var s = instance_create_layer(xx, yy, "Instances", obj_player_hitbox);
			s.image_angle = dir;
			
			/*
			if (!ds_exists(hit_by_attack, ds_type_list)) hit_by_attack = ds_list_create();
			ds_list_clear(hit_by_attack);
			
			calc_attack(obj_player_hitbox);*/
		}
		
		if (attack_timer <= 0) {
			state = enemyStates.chase;
		}
	}
}
	
	
function enemy_state_hurt() {
	sprite_index = spr_hurt;
	var _distanceToGo = point_distance(x,y,xTo,yTo);
	
	if (_distanceToGo > enemy_speed) {
		image_speed = 1;
		dir = point_direction(x,y,xTo,yTo);
		moveX = lengthdir_x(enemy_speed, dir);
		moveY = lengthdir_y(enemy_speed, dir);
		
		x += moveX;
		y += moveY;
		
		if (moveX != 0) image_xscale = -sign(moveX);
		
		//Collide and move
		if (enemy_collision()) {
			xTo = x;
			yTo = y;
		}
	} else {
		x = xTo;
		y = yTo;
		if (state_previous != enemyStates.attack) state = state_previous; else state = enemyStates.chase;
	}
	
}


function enemy_state_die() {
	sprite_index = spr_die;
	image_speed = 0;
	
	var _distanceToGo = point_distance(x,y,xTo,yTo);
	
	if (_distanceToGo > enemy_speed) {
		dir = point_direction(x,y,xTo,yTo);
		moveX = lengthdir_x(enemy_speed, dir);
		moveY = lengthdir_y(enemy_speed, dir);
		
		x += moveX;
		y += moveY;
		
		if (moveX != 0) image_xscale = -sign(moveX);
		
		//Collide and move
		if (enemy_collision()) {
			xTo = x;
			yTo = y;
		}
	} else {
		x = xTo;
		y = yTo;
	}
	
	//For animated death sprites
	if (image_index + (sprite_get_speed(sprite_index) / game_get_speed(gamespeed_fps)) >= image_number) {
		instance_destroy();
	}
}