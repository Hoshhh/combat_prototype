
function calc_attack(_hitbox){
	with(_hitbox) {
		var _hitByAttackNow = ds_list_create();
		var _hits = instance_place_list(x, y, par_entity, _hitByAttackNow, false);
	
		if (_hits > 0) {
			for(var i = 0; i < _hits; i++) {
				var _hitID = _hitByAttackNow[| i];
				if (ds_list_find_index(other.hit_by_attack, _hitID) == -1) {
					ds_list_add(other.hit_by_attack, _hitID);
					with(_hitID) {
						if (object_is_ancestor(object_index, par_entity)) {
							hurt_enemy(id, 5, other.id, 10)	
						} else {
							if (entity_hit_script != -1) script_execute(entity_hit_script);
						}
					}
				}
			}
		}
	
		ds_list_destroy(_hitByAttackNow);
	}
}

function hurt_enemy(_enemy, _dmg, _source, _knockback) {
	with(_enemy) {
		if (state != enemyStates.die) {
			enemy_hp -= _dmg;
			flash = 1;
			
			//hurt or dead
			if (enemy_hp <= 0) {
				state = enemyStates.die;	
			} else {
				if (state != enemyStates.hurt) state_previous = state;
				state = enemyStates.hurt;
			}
			
			image_index = 0;
			if (_knockback != 0) {
				var _knock_dir = point_direction(x, y, (_source.x), (_source.y));
				xTo = x - lengthdir_x(_knockback, _knock_dir);
				yTo = y - lengthdir_y(_knockback, _knock_dir);
			}
		}
	}
}