#macro RESOLUTION_W 320
#macro RESOLUTION_H 180
#macro ROOM_START rm_test


enum enemyStates {
	idle,
	wander,
	chase,
	knockback,
	attack,
	hurt,
	die,
	wait
}