/// @description Set up server and sockets using UDP

// CREATE SERVER
server = network_create_server(network_socket_udp, 400100, 2);

// CREATE CLIENT SOCKET AND LISTEN
client = network_create_socket(network_socket_udp);
network_connect(client, "127.0.0.1", 400100);

