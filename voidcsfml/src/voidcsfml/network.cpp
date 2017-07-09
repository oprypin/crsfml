#include <voidcsfml/network.h>
#include <SFML/Network.hpp>
using namespace sf;
void sfml_socket_finalize(void* self) {
    ((Socket*)self)->~Socket();
}
void sfml_socket_setblocking_GZq(void* self, unsigned char blocking) {
    ((Socket*)self)->setBlocking(blocking != 0);
}
void sfml_socket_isblocking(void* self, unsigned char* result) {
    *(bool*)result = ((Socket*)self)->isBlocking();
}
void sfml_tcpsocket_initialize(void* self) {
    new(self) TcpSocket();
}
void sfml_tcpsocket_getlocalport(void* self, unsigned short* result) {
    *(unsigned short*)result = ((TcpSocket*)self)->getLocalPort();
}
void sfml_tcpsocket_getremoteaddress(void* self, void* result) {
    *(IpAddress*)result = ((TcpSocket*)self)->getRemoteAddress();
}
void sfml_tcpsocket_getremoteport(void* self, unsigned short* result) {
    *(unsigned short*)result = ((TcpSocket*)self)->getRemotePort();
}
void sfml_tcpsocket_connect_BfEbxif4T(void* self, void* remote_address, unsigned short remote_port, void* timeout, int* result) {
    *(Socket::Status*)result = ((TcpSocket*)self)->connect(*(IpAddress*)remote_address, (unsigned short)remote_port, *(Time*)timeout);
}
void sfml_tcpsocket_disconnect(void* self) {
    ((TcpSocket*)self)->disconnect();
}
void sfml_tcpsocket_send_5h8vgv(void* self, void* data, size_t size, int* result) {
    *(Socket::Status*)result = ((TcpSocket*)self)->send(data, size);
}
void sfml_tcpsocket_send_5h8vgvi49(void* self, void* data, size_t size, size_t* sent, int* result) {
    *(Socket::Status*)result = ((TcpSocket*)self)->send(data, size, *(std::size_t*)sent);
}
void sfml_tcpsocket_receive_xALvgvi49(void* self, void* data, size_t size, size_t* received, int* result) {
    *(Socket::Status*)result = ((TcpSocket*)self)->receive(data, size, *(std::size_t*)received);
}
void sfml_tcpsocket_send_jyF(void* self, void* packet, int* result) {
    *(Socket::Status*)result = ((TcpSocket*)self)->send(*(Packet*)packet);
}
void sfml_tcpsocket_receive_jyF(void* self, void* packet, int* result) {
    *(Socket::Status*)result = ((TcpSocket*)self)->receive(*(Packet*)packet);
}
void sfml_tcpsocket_setblocking_GZq(void* self, unsigned char blocking) {
    ((TcpSocket*)self)->setBlocking(blocking != 0);
}
void sfml_tcpsocket_isblocking(void* self, unsigned char* result) {
    *(bool*)result = ((TcpSocket*)self)->isBlocking();
}
void sfml_ftp_initialize(void* self) {
    new(self) Ftp();
}
void sfml_ftp_response_initialize_nyWzkC(void* self, int code, size_t message_size, char* message) {
    new(self) Ftp::Response((Ftp::Response::Status)code, std::string(message, message_size));
}
void sfml_ftp_response_isok(void* self, unsigned char* result) {
    *(bool*)result = ((Ftp::Response*)self)->isOk();
}
void sfml_ftp_response_getstatus(void* self, int* result) {
    *(Ftp::Response::Status*)result = ((Ftp::Response*)self)->getStatus();
}
void sfml_ftp_response_getmessage(void* self, char** result) {
    static std::string str;
    str = ((Ftp::Response*)self)->getMessage();
    *result = const_cast<char*>(str.c_str());
}
void sfml_ftp_response_initialize_lXv(void* self, void* copy) {
    new(self) Ftp::Response(*(Ftp::Response*)copy);
}
void sfml_ftp_directoryresponse_initialize_lXv(void* self, void* response) {
    new(self) Ftp::DirectoryResponse(*(Ftp::Response*)response);
}
void sfml_ftp_directoryresponse_getdirectory(void* self, char** result) {
    static std::string str;
    str = ((Ftp::DirectoryResponse*)self)->getDirectory();
    *result = const_cast<char*>(str.c_str());
}
void sfml_ftp_directoryresponse_isok(void* self, unsigned char* result) {
    *(bool*)result = ((Ftp::DirectoryResponse*)self)->isOk();
}
void sfml_ftp_directoryresponse_getstatus(void* self, int* result) {
    *(Ftp::Response::Status*)result = ((Ftp::DirectoryResponse*)self)->getStatus();
}
void sfml_ftp_directoryresponse_getmessage(void* self, char** result) {
    static std::string str;
    str = ((Ftp::DirectoryResponse*)self)->getMessage();
    *result = const_cast<char*>(str.c_str());
}
void sfml_ftp_directoryresponse_initialize_Zyp(void* self, void* copy) {
    new(self) Ftp::DirectoryResponse(*(Ftp::DirectoryResponse*)copy);
}
void sfml_ftp_listingresponse_initialize_lXvzkC(void* self, void* response, size_t data_size, char* data) {
    new(self) Ftp::ListingResponse(*(Ftp::Response*)response, std::string(data, data_size));
}
void sfml_ftp_listingresponse_getlisting(void* self, char*** result, size_t* result_size) {
    static std::vector<std::string> strs;
    static std::vector<char*> bufs;
    strs = ((Ftp::ListingResponse*)self)->getListing();
    bufs.resize(strs.size());
    for (std::size_t i = 0; i < strs.size(); ++i) bufs[i] = const_cast<char*>(strs[i].c_str());
    *result_size = bufs.size();
    *result = &bufs[0];
}
void sfml_ftp_listingresponse_isok(void* self, unsigned char* result) {
    *(bool*)result = ((Ftp::ListingResponse*)self)->isOk();
}
void sfml_ftp_listingresponse_getstatus(void* self, int* result) {
    *(Ftp::Response::Status*)result = ((Ftp::ListingResponse*)self)->getStatus();
}
void sfml_ftp_listingresponse_getmessage(void* self, char** result) {
    static std::string str;
    str = ((Ftp::ListingResponse*)self)->getMessage();
    *result = const_cast<char*>(str.c_str());
}
void sfml_ftp_listingresponse_initialize_2ho(void* self, void* copy) {
    new(self) Ftp::ListingResponse(*(Ftp::ListingResponse*)copy);
}
void sfml_ftp_finalize(void* self) {
    ((Ftp*)self)->~Ftp();
}
void sfml_ftp_connect_BfEbxif4T(void* self, void* server, unsigned short port, void* timeout, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->connect(*(IpAddress*)server, (unsigned short)port, *(Time*)timeout);
}
void sfml_ftp_disconnect(void* self, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->disconnect();
}
void sfml_ftp_login(void* self, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->login();
}
void sfml_ftp_login_zkCzkC(void* self, size_t name_size, char* name, size_t password_size, char* password, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->login(std::string(name, name_size), std::string(password, password_size));
}
void sfml_ftp_keepalive(void* self, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->keepAlive();
}
void sfml_ftp_getworkingdirectory(void* self, void* result) {
    *(Ftp::DirectoryResponse*)result = ((Ftp*)self)->getWorkingDirectory();
}
void sfml_ftp_getdirectorylisting_zkC(void* self, size_t directory_size, char* directory, void* result) {
    *(Ftp::ListingResponse*)result = ((Ftp*)self)->getDirectoryListing(std::string(directory, directory_size));
}
void sfml_ftp_changedirectory_zkC(void* self, size_t directory_size, char* directory, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->changeDirectory(std::string(directory, directory_size));
}
void sfml_ftp_parentdirectory(void* self, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->parentDirectory();
}
void sfml_ftp_createdirectory_zkC(void* self, size_t name_size, char* name, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->createDirectory(std::string(name, name_size));
}
void sfml_ftp_deletedirectory_zkC(void* self, size_t name_size, char* name, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->deleteDirectory(std::string(name, name_size));
}
void sfml_ftp_renamefile_zkCzkC(void* self, size_t file_size, char* file, size_t new_name_size, char* new_name, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->renameFile(std::string(file, file_size), std::string(new_name, new_name_size));
}
void sfml_ftp_deletefile_zkC(void* self, size_t name_size, char* name, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->deleteFile(std::string(name, name_size));
}
void sfml_ftp_download_zkCzkCJP8(void* self, size_t remote_file_size, char* remote_file, size_t local_path_size, char* local_path, int mode, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->download(std::string(remote_file, remote_file_size), std::string(local_path, local_path_size), (Ftp::TransferMode)mode);
}
void sfml_ftp_upload_zkCzkCJP8(void* self, size_t local_file_size, char* local_file, size_t remote_path_size, char* remote_path, int mode, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->upload(std::string(local_file, local_file_size), std::string(remote_path, remote_path_size), (Ftp::TransferMode)mode);
}
void sfml_ftp_sendcommand_zkCzkC(void* self, size_t command_size, char* command, size_t parameter_size, char* parameter, void* result) {
    *(Ftp::Response*)result = ((Ftp*)self)->sendCommand(std::string(command, command_size), std::string(parameter, parameter_size));
}
void sfml_ipaddress_initialize(void* self) {
    new(self) IpAddress();
}
void sfml_ipaddress_initialize_zkC(void* self, size_t address_size, char* address) {
    new(self) IpAddress(std::string(address, address_size));
}
void sfml_ipaddress_initialize_Yy6(void* self, char* address) {
    new(self) IpAddress(address);
}
void sfml_ipaddress_initialize_9yU9yU9yU9yU(void* self, uint8_t byte0, uint8_t byte1, uint8_t byte2, uint8_t byte3) {
    new(self) IpAddress((Uint8)byte0, (Uint8)byte1, (Uint8)byte2, (Uint8)byte3);
}
void sfml_ipaddress_initialize_saL(void* self, uint32_t address) {
    new(self) IpAddress((Uint32)address);
}
void sfml_ipaddress_tostring(void* self, char** result) {
    static std::string str;
    str = ((IpAddress*)self)->toString();
    *result = const_cast<char*>(str.c_str());
}
void sfml_ipaddress_tointeger(void* self, uint32_t* result) {
    *(Uint32*)result = ((IpAddress*)self)->toInteger();
}
void sfml_ipaddress_getlocaladdress(void* result) {
    *(IpAddress*)result = IpAddress::getLocalAddress();
}
void sfml_ipaddress_getpublicaddress_f4T(void* timeout, void* result) {
    *(IpAddress*)result = IpAddress::getPublicAddress(*(Time*)timeout);
}
void sfml_operator_eq_BfEBfE(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator==(*(IpAddress*)left, *(IpAddress*)right);
}
void sfml_operator_ne_BfEBfE(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator!=(*(IpAddress*)left, *(IpAddress*)right);
}
void sfml_operator_lt_BfEBfE(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator<(*(IpAddress*)left, *(IpAddress*)right);
}
void sfml_operator_gt_BfEBfE(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator>(*(IpAddress*)left, *(IpAddress*)right);
}
void sfml_operator_le_BfEBfE(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator<=(*(IpAddress*)left, *(IpAddress*)right);
}
void sfml_operator_ge_BfEBfE(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator>=(*(IpAddress*)left, *(IpAddress*)right);
}
void sfml_ipaddress_initialize_BfE(void* self, void* copy) {
    new(self) IpAddress(*(IpAddress*)copy);
}
void sfml_http_request_initialize_zkC1ctzkC(void* self, size_t uri_size, char* uri, int method, size_t body_size, char* body) {
    new(self) Http::Request(std::string(uri, uri_size), (Http::Request::Method)method, std::string(body, body_size));
}
void sfml_http_request_setfield_zkCzkC(void* self, size_t field_size, char* field, size_t value_size, char* value) {
    ((Http::Request*)self)->setField(std::string(field, field_size), std::string(value, value_size));
}
void sfml_http_request_setmethod_1ct(void* self, int method) {
    ((Http::Request*)self)->setMethod((Http::Request::Method)method);
}
void sfml_http_request_seturi_zkC(void* self, size_t uri_size, char* uri) {
    ((Http::Request*)self)->setUri(std::string(uri, uri_size));
}
void sfml_http_request_sethttpversion_emSemS(void* self, unsigned int major, unsigned int minor) {
    ((Http::Request*)self)->setHttpVersion((unsigned int)major, (unsigned int)minor);
}
void sfml_http_request_setbody_zkC(void* self, size_t body_size, char* body) {
    ((Http::Request*)self)->setBody(std::string(body, body_size));
}
void sfml_http_request_initialize_Jat(void* self, void* copy) {
    new(self) Http::Request(*(Http::Request*)copy);
}
void sfml_http_response_initialize(void* self) {
    new(self) Http::Response();
}
void sfml_http_response_getfield_zkC(void* self, size_t field_size, char* field, char** result) {
    static std::string str;
    str = ((Http::Response*)self)->getField(std::string(field, field_size));
    *result = const_cast<char*>(str.c_str());
}
void sfml_http_response_getstatus(void* self, int* result) {
    *(Http::Response::Status*)result = ((Http::Response*)self)->getStatus();
}
void sfml_http_response_getmajorhttpversion(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Http::Response*)self)->getMajorHttpVersion();
}
void sfml_http_response_getminorhttpversion(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Http::Response*)self)->getMinorHttpVersion();
}
void sfml_http_response_getbody(void* self, char** result) {
    static std::string str;
    str = ((Http::Response*)self)->getBody();
    *result = const_cast<char*>(str.c_str());
}
void sfml_http_response_initialize_N50(void* self, void* copy) {
    new(self) Http::Response(*(Http::Response*)copy);
}
void sfml_http_initialize(void* self) {
    new(self) Http();
}
void sfml_http_initialize_zkCbxi(void* self, size_t host_size, char* host, unsigned short port) {
    new(self) Http(std::string(host, host_size), (unsigned short)port);
}
void sfml_http_sethost_zkCbxi(void* self, size_t host_size, char* host, unsigned short port) {
    ((Http*)self)->setHost(std::string(host, host_size), (unsigned short)port);
}
void sfml_http_sendrequest_Jatf4T(void* self, void* request, void* timeout, void* result) {
    *(Http::Response*)result = ((Http*)self)->sendRequest(*(Http::Request*)request, *(Time*)timeout);
}
void sfml_packet_initialize(void* self) {
    new(self) Packet();
}
void sfml_packet_finalize(void* self) {
    ((Packet*)self)->~Packet();
}
void sfml_packet_append_5h8vgv(void* self, void* data, size_t size_in_bytes) {
    ((Packet*)self)->append(data, size_in_bytes);
}
void sfml_packet_clear(void* self) {
    ((Packet*)self)->clear();
}
void sfml_packet_getdata(void* self, void** result) {
    *(void**)result = const_cast<void*>(((Packet*)self)->getData());
}
void sfml_packet_getdatasize(void* self, size_t* result) {
    *(std::size_t*)result = ((Packet*)self)->getDataSize();
}
void sfml_packet_endofpacket(void* self, unsigned char* result) {
    *(bool*)result = ((Packet*)self)->endOfPacket();
}
void sfml_packet_operator_bool(void* self, unsigned char* result) {
    *(bool*)result = (bool)((Packet*)self);
}
void sfml_packet_operator_shr_gRY(void* self, unsigned char* data) {
    ((Packet*)self)->operator>>(*(bool*)data);
}
void sfml_packet_operator_shr_0y9(void* self, int8_t* data) {
    ((Packet*)self)->operator>>(*(Int8*)data);
}
void sfml_packet_operator_shr_8hc(void* self, uint8_t* data) {
    ((Packet*)self)->operator>>(*(Uint8*)data);
}
void sfml_packet_operator_shr_4k3(void* self, int16_t* data) {
    ((Packet*)self)->operator>>(*(Int16*)data);
}
void sfml_packet_operator_shr_Xag(void* self, uint16_t* data) {
    ((Packet*)self)->operator>>(*(Uint16*)data);
}
void sfml_packet_operator_shr_NiZ(void* self, int32_t* data) {
    ((Packet*)self)->operator>>(*(Int32*)data);
}
void sfml_packet_operator_shr_qTz(void* self, uint32_t* data) {
    ((Packet*)self)->operator>>(*(Uint32*)data);
}
void sfml_packet_operator_shr_BuW(void* self, int64_t* data) {
    ((Packet*)self)->operator>>(*(Int64*)data);
}
void sfml_packet_operator_shr_7H7(void* self, uint64_t* data) {
    ((Packet*)self)->operator>>(*(Uint64*)data);
}
void sfml_packet_operator_shr_ATF(void* self, float* data) {
    ((Packet*)self)->operator>>(*(float*)data);
}
void sfml_packet_operator_shr_nIp(void* self, double* data) {
    ((Packet*)self)->operator>>(*(double*)data);
}
void sfml_packet_operator_shr_GHF(void* self, char** data) {
    static std::string str;
    ((Packet*)self)->operator>>(str);
    *data = const_cast<char*>(str.c_str());
}
void sfml_packet_operator_shl_GZq(void* self, unsigned char data) {
    ((Packet*)self)->operator<<(data != 0);
}
void sfml_packet_operator_shl_k6g(void* self, int8_t data) {
    ((Packet*)self)->operator<<((Int8)data);
}
void sfml_packet_operator_shl_9yU(void* self, uint8_t data) {
    ((Packet*)self)->operator<<((Uint8)data);
}
void sfml_packet_operator_shl_yAA(void* self, int16_t data) {
    ((Packet*)self)->operator<<((Int16)data);
}
void sfml_packet_operator_shl_BtU(void* self, uint16_t data) {
    ((Packet*)self)->operator<<((Uint16)data);
}
void sfml_packet_operator_shl_qe2(void* self, int32_t data) {
    ((Packet*)self)->operator<<((Int32)data);
}
void sfml_packet_operator_shl_saL(void* self, uint32_t data) {
    ((Packet*)self)->operator<<((Uint32)data);
}
void sfml_packet_operator_shl_G4x(void* self, int64_t data) {
    ((Packet*)self)->operator<<((Int64)data);
}
void sfml_packet_operator_shl_Jvt(void* self, uint64_t data) {
    ((Packet*)self)->operator<<((Uint64)data);
}
void sfml_packet_operator_shl_Bw9(void* self, float data) {
    ((Packet*)self)->operator<<((float)data);
}
void sfml_packet_operator_shl_mYt(void* self, double data) {
    ((Packet*)self)->operator<<((double)data);
}
void sfml_packet_operator_shl_zkC(void* self, size_t data_size, char* data) {
    ((Packet*)self)->operator<<(std::string(data, data_size));
}
void sfml_packet_initialize_54U(void* self, void* copy) {
    new(self) Packet(*(Packet*)copy);
}
void sfml_socketselector_initialize(void* self) {
    new(self) SocketSelector();
}
void sfml_socketselector_finalize(void* self) {
    ((SocketSelector*)self)->~SocketSelector();
}
void sfml_socketselector_add_JTp(void* self, void* socket) {
    ((SocketSelector*)self)->add(*(Socket*)socket);
}
void sfml_socketselector_remove_JTp(void* self, void* socket) {
    ((SocketSelector*)self)->remove(*(Socket*)socket);
}
void sfml_socketselector_clear(void* self) {
    ((SocketSelector*)self)->clear();
}
void sfml_socketselector_wait_f4T(void* self, void* timeout, unsigned char* result) {
    *(bool*)result = ((SocketSelector*)self)->wait(*(Time*)timeout);
}
void sfml_socketselector_isready_JTp(void* self, void* socket, unsigned char* result) {
    *(bool*)result = ((SocketSelector*)self)->isReady(*(Socket*)socket);
}
void sfml_socketselector_initialize_fWq(void* self, void* copy) {
    new(self) SocketSelector(*(SocketSelector*)copy);
}
void sfml_tcplistener_initialize(void* self) {
    new(self) TcpListener();
}
void sfml_tcplistener_getlocalport(void* self, unsigned short* result) {
    *(unsigned short*)result = ((TcpListener*)self)->getLocalPort();
}
void sfml_tcplistener_listen_bxiBfE(void* self, unsigned short port, void* address, int* result) {
    *(Socket::Status*)result = ((TcpListener*)self)->listen((unsigned short)port, *(IpAddress*)address);
}
void sfml_tcplistener_close(void* self) {
    ((TcpListener*)self)->close();
}
void sfml_tcplistener_accept_WsF(void* self, void* socket, int* result) {
    *(Socket::Status*)result = ((TcpListener*)self)->accept(*(TcpSocket*)socket);
}
void sfml_tcplistener_setblocking_GZq(void* self, unsigned char blocking) {
    ((TcpListener*)self)->setBlocking(blocking != 0);
}
void sfml_tcplistener_isblocking(void* self, unsigned char* result) {
    *(bool*)result = ((TcpListener*)self)->isBlocking();
}
void sfml_udpsocket_initialize(void* self) {
    new(self) UdpSocket();
}
void sfml_udpsocket_getlocalport(void* self, unsigned short* result) {
    *(unsigned short*)result = ((UdpSocket*)self)->getLocalPort();
}
void sfml_udpsocket_bind_bxiBfE(void* self, unsigned short port, void* address, int* result) {
    *(Socket::Status*)result = ((UdpSocket*)self)->bind((unsigned short)port, *(IpAddress*)address);
}
void sfml_udpsocket_unbind(void* self) {
    ((UdpSocket*)self)->unbind();
}
void sfml_udpsocket_send_5h8vgvBfEbxi(void* self, void* data, size_t size, void* remote_address, unsigned short remote_port, int* result) {
    *(Socket::Status*)result = ((UdpSocket*)self)->send(data, size, *(IpAddress*)remote_address, (unsigned short)remote_port);
}
void sfml_udpsocket_receive_xALvgvi499ylYII(void* self, void* data, size_t size, size_t* received, void* remote_address, unsigned short* remote_port, int* result) {
    *(Socket::Status*)result = ((UdpSocket*)self)->receive(data, size, *(std::size_t*)received, *(IpAddress*)remote_address, *(unsigned short*)remote_port);
}
void sfml_udpsocket_send_jyFBfEbxi(void* self, void* packet, void* remote_address, unsigned short remote_port, int* result) {
    *(Socket::Status*)result = ((UdpSocket*)self)->send(*(Packet*)packet, *(IpAddress*)remote_address, (unsigned short)remote_port);
}
void sfml_udpsocket_receive_jyF9ylYII(void* self, void* packet, void* remote_address, unsigned short* remote_port, int* result) {
    *(Socket::Status*)result = ((UdpSocket*)self)->receive(*(Packet*)packet, *(IpAddress*)remote_address, *(unsigned short*)remote_port);
}
void sfml_udpsocket_setblocking_GZq(void* self, unsigned char blocking) {
    ((UdpSocket*)self)->setBlocking(blocking != 0);
}
void sfml_udpsocket_isblocking(void* self, unsigned char* result) {
    *(bool*)result = ((UdpSocket*)self)->isBlocking();
}
void sfml_network_version(int* major, int* minor, int* patch) {
    *major = SFML_VERSION_MAJOR;
    *minor = SFML_VERSION_MINOR;
    *patch = SFML_VERSION_PATCH;
}
