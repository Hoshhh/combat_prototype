// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function enemy_collision(){
	var _collision = false;
	//Collision checks
	//-----horizontal
	if (moveX != 0) {
		var collisionH = instance_place(x + moveX, y, obj_collision)
		if (collisionH) {
			repeat(abs(moveX)) {
				if (!place_meeting(x+sign(moveX), y, obj_collision)) {
					x += sign(moveX);
				} else { break; }
			}
			moveX = 0;
			_collision = true;
		}
	}
	

	//-----vertical
	if (moveY != 0) {
		var collisionV = instance_place(x, y+moveY, obj_collision)
		if (collisionV) {
			repeat(abs(moveY)) {
				if (!place_meeting(x, y+sign(moveY), obj_collision)) {
					y += sign(moveY);
				} else { break; }
			}
			moveY = 0;
			_collision = true;
		}
	}
	
	return _collision;
}