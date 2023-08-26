
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
						if (entity_hit_script != -1) script_execute(entity_hit_script);
					}
				}
			}
		}
	
		ds_list_destroy(_hitByAttackNow);
	}
}