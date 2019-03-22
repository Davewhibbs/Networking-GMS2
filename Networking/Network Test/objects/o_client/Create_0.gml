/// @description BUFFERS


// CREATE BUFFER
buff = buffer_create( 256, buffer_grow, 1);

// WRITE TO THE BUFFER AND SEND
buffer_seek(buff, buffer_seek_start, 0);
buffer_write(buff, buffer_s16, NAME_CMD);
buffer_write(buff, buffer_string, player_name);
network_send_packet(client, buff, buffer_tell(buff));
