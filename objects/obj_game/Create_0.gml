global.game_paused = false;
global.text_speed = 0.75;
global.i_camera = instance_create_layer(x,y, layer, obj_camera);

//surface_resize(application_surface, RESOLUTION_W, RESOLUTION_H)
display_set_gui_size(RESOLUTION_W,RESOLUTION_H);
room_goto(ROOM_START);




