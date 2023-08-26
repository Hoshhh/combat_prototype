
function enemy_state_free(){

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
		state = enemyStates.free;	
	}
	
	//Change height
	z = sin(((move_distance_remaining / knockback_distance) * pi)) * knockback_height;
	
	//Check collisions
	Collision()
			
	x += moveX;
	y += moveY;
}


function enemy_state_attack(){
	
}