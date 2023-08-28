if (!global.game_paused) {
	if (enemyStates_array[state] != -1) {
		script_execute(enemyStates_array[state]);
		depth = -bbox_bottom;
	}
}