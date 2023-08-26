//Inputs
input_left		=	keyboard_check(ord("A"));
input_right		=	keyboard_check(ord("D"));
input_up		=	keyboard_check(ord("W"));
input_down		=	keyboard_check(ord("S"));
input_attack	=	mouse_check_button_pressed(mb_left);
input_dash		=	keyboard_check_pressed(vk_space);
input_walk		=	keyboard_check(vk_control);
input_run		=	keyboard_check(vk_shift);

input_direction = point_direction(0,0, input_right-input_left, input_down-input_up);
input_magnitude = (input_right-input_left != 0) || (input_down-input_up != 0);

script_execute(states_array[state]);

depth = -y;