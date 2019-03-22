/// @description CONNECTING / DISCONNECTING

var eventid = async_load[? "id" ];

var t = async_load[? "type"];


// DETECT CONNECTION
if t == network_type_connect 
{
	var sock = async_load[? "socket"];
	var ip = async_load[? "ip"];
	
	var inst = instance_create_layer(64, 192, "Instances", o_player);
	ds_map_add(clients, sock, inst);
}



// DETECT DISCONNECTION
if t == network_type_disconnect 
{
	var inst = Clients[? sock];
	ds_map_delete(Clients, sock);
	instance_destroy(inst, true);
}



// ---------------------RECEIVING DATA

// Check the incoming socket ID against the socket ID we stored when we created the server
if server == eventid
{
	// Incoming data from the server so it's a connect/disconnect event and we can deal with it here
}
else if eventid != global.client // don't deal with data coming from the client running on the devise that also runs the server
{
	// Deal with received data here from connected clients
}


var sock = async_load[? "id"];
var inst = Clients[? sock];
var buff = async_load[? "buffer"];
var cmd = buffer_read(buff, buffer_s16);

switch (cmd)
{
	case KEY_CMD:
		// Read the key that was sent
		var key = buffer_read(buff, buffer_s16);
		
		// And it's up/down state
		var updown = buffer_read(buff, buffer_s16);
		
		// Translate keypress into an index for our player array
		if		key == vk_left	key = LEFT_KEY;
		else if key == vk_right key = RIGHT_KEY;
		else if key == vk_up	key = UP_KEY;
		else if key == vk_down	key = DOWN_KEY;
		
		if updown == 0	inst.keys[key] = false;
		else			inst.keys[key] = true;
		
		break;
		
		
	case NAME_CMD:
		inst.PlayerName = buffer_read(buff, buffer_string);
		break;
		
	case PING_CMD:
		break;
}
