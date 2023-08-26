
function player_state_free(){
	//Alter Speed
	if (input_walk || input_run) {
		spd = abs((input_walk * w_spd) - (input_run * r_spd));
	} else {
		spd = n_spd;	
	}


	//Reset move varaibles
	moveX = 0;
	moveY = 0;


	//Intended movement
	var hor = (input_right - input_left)
	var vert = (input_down - input_up)
	var diagonalSpeed = spd * 0.707;
	

	//Normalize the Diagonal movement
	if (hor != 0 and vert != 0) {
		moveX = hor * diagonalSpeed;
		moveY = vert * diagonalSpeed;
	} else {
		moveX = hor * spd;
		moveY = vert * spd;
	}
	
	//Collision checking
	Collision();
	
	if (input_magnitude != 0) {
		direction = input_direction;	
	}
	
	//Apply movement
	x += moveX;
	y += moveY;
	
	
	//Dash cooldown
	if (dash_cooldown > 0) {
		dash_cooldown--;
	}
	
	//State changes
	//-----Dashing
	if (input_dash && dash_cooldown <= 0) {
		state = states.dash;	
	}
	
	//-----Attacking
	if (input_attack) {
		state = states.attack;
		attack_timer = 10;
	}
	
}


function player_state_dash(){
	if (is_dashing) {
		dash_duration--;
		
		if (dash_duration > 0) {
			moveX = lengthdir_x(4, direction);
			moveY = lengthdir_y(4, direction);
			
			//Check collisions
			Collision()
			
			x += moveX;
			y += moveY
		} else {
			state = states.free;
			is_dashing = false;
			dash_cooldown = 60;
		}
	} else {
		//If we're not dashing, then START DASHING
		is_dashing = true;
		dash_duration = 15;	
	}
}


function player_state_attack(){
	//Temp melee
	if (!instance_exists(obj_player_hitbox)) {
		attack_timer--;
		
		var dist = 2
		var dir = point_direction(x, y, mouse_x, mouse_y);
		var xx = x + lengthdir_x(dist, dir);
		var yy = (y-8) + lengthdir_y(dist, dir);

		// Create slash
		if (attack_timer == 8) {
			var s = instance_create_layer(xx, yy, "Instances", obj_player_hitbox);
			s.image_angle = dir;
			
			if (!ds_exists(hit_by_attack, ds_type_list)) hit_by_attack = ds_list_create();
			ds_list_clear(hit_by_attack);
			
			calc_attack(obj_player_hitbox);
		}
		
		if (attack_timer <= 0) {
			state = states.free;
		}
	}
	
	//Allows dashing while in the attack state
	if (input_dash && dash_cooldown <= 0) {
		state = states.dash;	
	}
}