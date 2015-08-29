require "./common_lib"
require "./system_lib"

@[Link("csfml-network")]
# :nodoc:
lib CSFML
  # Encapsulate an IPv4 network address
  struct IpAddress
    address: UInt8[16]
  end
  
  # Create an address from a string
  # 
  # Here `address` can be either a decimal address
  # (ex: "192.168.1.56") or a network name (ex: "localhost").
  # 
  # *Arguments*:
  # 
  # * `address`: IP address or network name
  # 
  # *Returns*: Resulting address
  fun ip_address_from_string = sfIpAddress_fromString(address: UInt8*): IpAddress
  
  # Create an address from 4 bytes
  # 
  # Calling IpAddress_fromBytes(a, b, c, d) is equivalent
  # to calling IpAddress_fromString("a.b.c.d"), but safer
  # as it doesn't have to parse a string to get the address
  # components.
  # 
  # *Arguments*:
  # 
  # * `byte0`: First byte of the address
  # * `byte1`: Second byte of the address
  # * `byte2`: Third byte of the address
  # * `byte3`: Fourth byte of the address
  # 
  # *Returns*: Resulting address
  fun ip_address_from_bytes = sfIpAddress_fromBytes(byte0: UInt8, byte1: UInt8, byte2: UInt8, byte3: UInt8): IpAddress
  
  # Construct an address from a 32-bits integer
  # 
  # This function uses the internal representation of
  # the address directly. It should be used for optimization
  # purposes, and only if you got that representation from
  # IpAddress_ToInteger.
  # 
  # *Arguments*:
  # 
  # * `address`: 4 bytes of the address packed into a 32-bits integer
  # 
  # *Returns*: Resulting address
  fun ip_address_from_integer = sfIpAddress_fromInteger(address: UInt32): IpAddress
  
  # Get a string representation of an address
  # 
  # The returned string is the decimal representation of the
  # IP address (like "192.168.1.56"), even if it was constructed
  # from a host name.
  # 
  # *Arguments*:
  # 
  # * `address`: Address object
  # 
  # *Returns*: String representation of the address
  fun ip_address_to_string = sfIpAddress_toString(address: IpAddress, string: UInt8*)
  
  # Get an integer representation of the address
  # 
  # The returned number is the internal representation of the
  # address, and should be used for optimization purposes only
  # (like sending the address through a socket).
  # The integer produced by this function can then be converted
  # back to a IpAddress with IpAddress_FromInteger.
  # 
  # *Arguments*:
  # 
  # * `address`: Address object
  # 
  # *Returns*: 32-bits unsigned integer representation of the address
  fun ip_address_to_integer = sfIpAddress_toInteger(address: IpAddress): UInt32
  
  # Get the computer's local address
  # 
  # The local address is the address of the computer from the
  # LAN point of view, i.e. something like 192.168.1.56. It is
  # meaningful only for communications over the local network.
  # Unlike IpAddress_getPublicAddress, this function is fast
  # and may be used safely anywhere.
  # 
  # *Returns*: Local IP address of the computer
  fun ip_address_get_local_address = sfIpAddress_getLocalAddress(): IpAddress
  
  # Get the computer's public address
  # 
  # The public address is the address of the computer from the
  # internet point of view, i.e. something like 89.54.1.169.
  # It is necessary for communications over the world wide web.
  # The only way to get a public address is to ask it to a
  # distant website; as a consequence, this function depends on
  # both your network connection and the server, and may be
  # very slow. You should use it as few as possible. Because
  # this function depends on the network connection and on a distant
  # server, you may use a time limit if you don't want your program
  # to be possibly stuck waiting in case there is a problem; use
  # 0 to deactivate this limit.
  # 
  # *Arguments*:
  # 
  # * `timeout`: Maximum time to wait
  # 
  # *Returns*: Public IP address of the computer
  fun ip_address_get_public_address = sfIpAddress_getPublicAddress(timeout: Time): IpAddress
  
  type FtpDirectoryResponse = Void*
  
  type FtpListingResponse = Void*
  
  type FtpResponse = Void*
  
  type Ftp = Void*
  
  type HttpRequest = Void*
  
  type HttpResponse = Void*
  
  type Http = Void*
  
  type Packet = Void*
  
  type SocketSelector = Void*
  
  type TcpListener = Void*
  
  type TcpSocket = Void*
  
  type UdpSocket = Void*
  
  # Enumeration of transfer modes
  enum FtpTransferMode
    Binary, Ascii, Ebcdic
  end
  
  # Status codes possibly returned by a FTP response
  enum FtpStatus
    RestartMarkerReply = 110, ServiceReadySoon = 120,
    DataConnectionAlreadyOpened = 125, OpeningDataConnection = 150, Ok = 200,
    PointlessCommand = 202, SystemStatus = 211, DirectoryStatus = 212,
    FileStatus = 213, HelpMessage = 214, SystemType = 215, ServiceReady = 220,
    ClosingConnection = 221, DataConnectionOpened = 225, ClosingDataConnection =
    226, EnteringPassiveMode = 227, LoggedIn = 230, FileActionOk = 250,
    DirectoryOk = 257, NeedPassword = 331, NeedAccountToLogIn = 332,
    NeedInformation = 350, ServiceUnavailable = 421, DataConnectionUnavailable =
    425, TransferAborted = 426, FileActionAborted = 450, LocalError = 451,
    InsufficientStorageSpace = 452, CommandUnknown = 500, ParametersUnknown =
    501, CommandNotImplemented = 502, BadCommandSequence = 503,
    ParameterNotImplemented = 504, NotLoggedIn = 530, NeedAccountToStore = 532,
    FileUnavailable = 550, PageTypeUnknown = 551, NotEnoughMemory = 552,
    FilenameNotAllowed = 553, InvalidResponse = 1000, ConnectionFailed = 1001,
    ConnectionClosed = 1002, InvalidFile = 1003
  end
  
  # Destroy a FTP listing response
  # 
  # *Arguments*:
  # 
  # * `ftp_listing_response`: Ftp listing response to destroy
  fun ftp_listing_response_destroy = sfFtpListingResponse_destroy(ftp_listing_response: FtpListingResponse)
  
  # Check if a FTP listing response status code means a success
  # 
  # This function is defined for convenience, it is
  # equivalent to testing if the status code is < 400.
  # 
  # *Arguments*:
  # 
  # * `ftp_listing_response`: Ftp listing response
  # 
  # *Returns*: True if the status is a success, False if it is a failure
  fun ftp_listing_response_is_ok = sfFtpListingResponse_isOk(ftp_listing_response: FtpListingResponse): CSFML::Bool
  
  # Get the status code of a FTP listing response
  # 
  # *Arguments*:
  # 
  # * `ftp_listing_response`: Ftp listing response
  # 
  # *Returns*: Status code
  fun ftp_listing_response_get_status = sfFtpListingResponse_getStatus(ftp_listing_response: FtpListingResponse): FtpStatus
  
  # Get the full message contained in a FTP listing response
  # 
  # *Arguments*:
  # 
  # * `ftp_listing_response`: Ftp listing response
  # 
  # *Returns*: The response message
  fun ftp_listing_response_get_message = sfFtpListingResponse_getMessage(ftp_listing_response: FtpListingResponse): UInt8*
  
  # Return the number of directory/file names contained in a FTP listing response
  # 
  # *Arguments*:
  # 
  # * `ftp_listing_response`: Ftp listing response
  # 
  # *Returns*: Total number of names available
  fun ftp_listing_response_get_count = sfFtpListingResponse_getCount(ftp_listing_response: FtpListingResponse): LibC::SizeT
  
  # Return a directory/file name contained in a FTP listing response
  # 
  # *Arguments*:
  # 
  # * `ftp_listing_response`: Ftp listing response
  # * `index`: Index of the name to get (in range [0 .. get_count])
  # 
  # *Returns*: The requested name
  fun ftp_listing_response_get_name = sfFtpListingResponse_getName(ftp_listing_response: FtpListingResponse, index: LibC::SizeT): UInt8*
  
  # Destroy a FTP directory response
  # 
  # *Arguments*:
  # 
  # * `ftp_directory_response`: Ftp directory response to destroy
  fun ftp_directory_response_destroy = sfFtpDirectoryResponse_destroy(ftp_directory_response: FtpDirectoryResponse)
  
  # Check if a FTP directory response status code means a success
  # 
  # This function is defined for convenience, it is
  # equivalent to testing if the status code is < 400.
  # 
  # *Arguments*:
  # 
  # * `ftp_directory_response`: Ftp directory response
  # 
  # *Returns*: True if the status is a success, False if it is a failure
  fun ftp_directory_response_is_ok = sfFtpDirectoryResponse_isOk(ftp_directory_response: FtpDirectoryResponse): CSFML::Bool
  
  # Get the status code of a FTP directory response
  # 
  # *Arguments*:
  # 
  # * `ftp_directory_response`: Ftp directory response
  # 
  # *Returns*: Status code
  fun ftp_directory_response_get_status = sfFtpDirectoryResponse_getStatus(ftp_directory_response: FtpDirectoryResponse): FtpStatus
  
  # Get the full message contained in a FTP directory response
  # 
  # *Arguments*:
  # 
  # * `ftp_directory_response`: Ftp directory response
  # 
  # *Returns*: The response message
  fun ftp_directory_response_get_message = sfFtpDirectoryResponse_getMessage(ftp_directory_response: FtpDirectoryResponse): UInt8*
  
  # Get the directory returned in a FTP directory response
  # 
  # *Arguments*:
  # 
  # * `ftp_directory_response`: Ftp directory response
  # 
  # *Returns*: Directory name
  fun ftp_directory_response_get_directory = sfFtpDirectoryResponse_getDirectory(ftp_directory_response: FtpDirectoryResponse): UInt8*
  
  # Destroy a FTP response
  # 
  # *Arguments*:
  # 
  # * `ftp_response`: Ftp response to destroy
  fun ftp_response_destroy = sfFtpResponse_destroy(ftp_response: FtpResponse)
  
  # Check if a FTP response status code means a success
  # 
  # This function is defined for convenience, it is
  # equivalent to testing if the status code is < 400.
  # 
  # *Arguments*:
  # 
  # * `ftp_response`: Ftp response object
  # 
  # *Returns*: True if the status is a success, False if it is a failure
  fun ftp_response_is_ok = sfFtpResponse_isOk(ftp_response: FtpResponse): CSFML::Bool
  
  # Get the status code of a FTP response
  # 
  # *Arguments*:
  # 
  # * `ftp_response`: Ftp response object
  # 
  # *Returns*: Status code
  fun ftp_response_get_status = sfFtpResponse_getStatus(ftp_response: FtpResponse): FtpStatus
  
  # Get the full message contained in a FTP response
  # 
  # *Arguments*:
  # 
  # * `ftp_response`: Ftp response object
  # 
  # *Returns*: The response message
  fun ftp_response_get_message = sfFtpResponse_getMessage(ftp_response: FtpResponse): UInt8*
  
  # Create a new Ftp object
  # 
  # *Returns*: A new Ftp object
  fun ftp_create = sfFtp_create(): Ftp
  
  # Destroy a Ftp object
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object to destroy
  fun ftp_destroy = sfFtp_destroy(ftp: Ftp)
  
  # Connect to the specified FTP server
  # 
  # The port should be 21, which is the standard
  # port used by the FTP protocol. You shouldn't use a different
  # value, unless you really know what you do.
  # This function tries to connect to the server so it may take
  # a while to complete, especially if the server is not
  # reachable. To avoid blocking your application for too long,
  # you can use a timeout. Using 0 means that the
  # system timeout will be used (which is usually pretty long).
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # * `server`: Name or address of the FTP server to connect to
  # * `port`: Port used for the connection
  # * `timeout`: Maximum time to wait
  # 
  # *Returns*: Server response to the request
  fun ftp_connect = sfFtp_connect(ftp: Ftp, server: IpAddress, port: UInt16, timeout: Time): FtpResponse
  
  # Log in using an anonymous account
  # 
  # Logging in is mandatory after connecting to the server.
  # Users that are not logged in cannot perform any operation.
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # 
  # *Returns*: Server response to the request
  fun ftp_login_anonymous = sfFtp_loginAnonymous(ftp: Ftp): FtpResponse
  
  # Log in using a username and a password
  # 
  # Logging in is mandatory after connecting to the server.
  # Users that are not logged in cannot perform any operation.
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # * `name`: User name
  # * `password`: Password
  # 
  # *Returns*: Server response to the request
  fun ftp_login = sfFtp_login(ftp: Ftp, user_name: UInt8*, password: UInt8*): FtpResponse
  
  # Close the connection with the server
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # 
  # *Returns*: Server response to the request
  fun ftp_disconnect = sfFtp_disconnect(ftp: Ftp): FtpResponse
  
  # Send a null command to keep the connection alive
  # 
  # This command is useful because the server may close the
  # connection automatically if no command is sent.
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # 
  # *Returns*: Server response to the request
  fun ftp_keep_alive = sfFtp_keepAlive(ftp: Ftp): FtpResponse
  
  # Get the current working directory
  # 
  # The working directory is the root path for subsequent
  # operations involving directories and/or filenames.
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # 
  # *Returns*: Server response to the request
  fun ftp_get_working_directory = sfFtp_getWorkingDirectory(ftp: Ftp): FtpDirectoryResponse
  
  # Get the contents of the given directory
  # 
  # This function retrieves the sub-directories and files
  # contained in the given directory. It is not recursive.
  # The `directory` parameter is relative to the current
  # working directory.
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # * `directory`: Directory to list
  # 
  # *Returns*: Server response to the request
  fun ftp_get_directory_listing = sfFtp_getDirectoryListing(ftp: Ftp, directory: UInt8*): FtpListingResponse
  
  # Change the current working directory
  # 
  # The new directory must be relative to the current one.
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # * `directory`: New working directory
  # 
  # *Returns*: Server response to the request
  fun ftp_change_directory = sfFtp_changeDirectory(ftp: Ftp, directory: UInt8*): FtpResponse
  
  # Go to the parent directory of the current one
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # 
  # *Returns*: Server response to the request
  fun ftp_parent_directory = sfFtp_parentDirectory(ftp: Ftp): FtpResponse
  
  # Create a new directory
  # 
  # The new directory is created as a child of the current
  # working directory.
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # * `name`: Name of the directory to create
  # 
  # *Returns*: Server response to the request
  fun ftp_create_directory = sfFtp_createDirectory(ftp: Ftp, name: UInt8*): FtpResponse
  
  # Remove an existing directory
  # 
  # The directory to remove must be relative to the
  # current working directory.
  # Use this function with caution, the directory will
  # be removed permanently!
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # * `name`: Name of the directory to remove
  # 
  # *Returns*: Server response to the request
  fun ftp_delete_directory = sfFtp_deleteDirectory(ftp: Ftp, name: UInt8*): FtpResponse
  
  # Rename an existing file
  # 
  # The filenames must be relative to the current working
  # directory.
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # * `file`: File to rename
  # * `new_name`: New name of the file
  # 
  # *Returns*: Server response to the request
  fun ftp_rename_file = sfFtp_renameFile(ftp: Ftp, file: UInt8*, new_name: UInt8*): FtpResponse
  
  # Remove an existing file
  # 
  # The file name must be relative to the current working
  # directory.
  # Use this function with caution, the file will be
  # removed permanently!
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # * `name`: File to remove
  # 
  # *Returns*: Server response to the request
  fun ftp_delete_file = sfFtp_deleteFile(ftp: Ftp, name: UInt8*): FtpResponse
  
  # Download a file from a FTP server
  # 
  # The filename of the distant file is relative to the
  # current working directory of the server, and the local
  # destination path is relative to the current directory
  # of your application.
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # * `remote_file`: Filename of the distant file to download
  # * `local_path`: Where to put to file on the local computer
  # * `mode`: Transfer mode
  # 
  # *Returns*: Server response to the request
  fun ftp_download = sfFtp_download(ftp: Ftp, distant_file: UInt8*, dest_path: UInt8*, mode: FtpTransferMode): FtpResponse
  
  # Upload a file to a FTP server
  # 
  # The name of the local file is relative to the current
  # working directory of your application, and the
  # remote path is relative to the current directory of the
  # FTP server.
  # 
  # *Arguments*:
  # 
  # * `ftp`: Ftp object
  # * `local_file`: Path of the local file to upload
  # * `remote_path`: Where to put to file on the server
  # * `mode`: Transfer mode
  # 
  # *Returns*: Server response to the request
  fun ftp_upload = sfFtp_upload(ftp: Ftp, local_file: UInt8*, dest_path: UInt8*, mode: FtpTransferMode): FtpResponse
  
  # Enumerate the available HTTP methods for a request
  enum HttpMethod
    Get, Post, Head, Put, Delete
  end
  
  # Enumerate all the valid status codes for a response
  enum HttpStatus
    Ok = 200, Created = 201, Accepted = 202, NoContent = 204, ResetContent =
    205, PartialContent = 206, MultipleChoices = 300, MovedPermanently = 301,
    MovedTemporarily = 302, NotModified = 304, BadRequest = 400, Unauthorized =
    401, Forbidden = 403, NotFound = 404, RangeNotSatisfiable = 407,
    InternalServerError = 500, NotImplemented = 501, BadGateway = 502,
    ServiceNotAvailable = 503, GatewayTimeout = 504, VersionNotSupported = 505,
    InvalidResponse = 1000, ConnectionFailed = 1001
  end
  
  # Create a new HTTP request
  # 
  # *Returns*: A new HttpRequest object
  fun http_request_create = sfHttpRequest_create(): HttpRequest
  
  # Destroy a HTTP request
  # 
  # *Arguments*:
  # 
  # * `http_request`: HTTP request to destroy
  fun http_request_destroy = sfHttpRequest_destroy(http_request: HttpRequest)
  
  # Set the value of a header field of a HTTP request
  # 
  # The field is created if it doesn't exist. The name of
  # the field is case insensitive.
  # By default, a request doesn't contain any field (but the
  # mandatory fields are added later by the HTTP client when
  # sending the request).
  # 
  # *Arguments*:
  # 
  # * `http_request`: HTTP request
  # * `field`: Name of the field to set
  # * `value`: Value of the field
  fun http_request_set_field = sfHttpRequest_setField(http_request: HttpRequest, field: UInt8*, value: UInt8*)
  
  # Set a HTTP request method
  # 
  # See the HttpMethod enumeration for a complete list of all
  # the availale methods.
  # The method is HttpGet by default.
  # 
  # *Arguments*:
  # 
  # * `http_request`: HTTP request
  # * `method`: Method to use for the request
  fun http_request_set_method = sfHttpRequest_setMethod(http_request: HttpRequest, method: HttpMethod)
  
  # Set a HTTP request URI
  # 
  # The URI is the resource (usually a web page or a file)
  # that you want to get or post.
  # The URI is "/" (the root page) by default.
  # 
  # *Arguments*:
  # 
  # * `http_request`: HTTP request
  # * `uri`: URI to request, relative to the host
  fun http_request_set_uri = sfHttpRequest_setUri(http_request: HttpRequest, uri: UInt8*)
  
  # Set the HTTP version of a HTTP request
  # 
  # The HTTP version is 1.0 by default.
  # 
  # *Arguments*:
  # 
  # * `http_request`: HTTP request
  # * `major`: Major HTTP version number
  # * `minor`: Minor HTTP version number
  fun http_request_set_http_version = sfHttpRequest_setHttpVersion(http_request: HttpRequest, major: Int32, minor: Int32)
  
  # Set the body of a HTTP request
  # 
  # The body of a request is optional and only makes sense
  # for POST requests. It is ignored for all other methods.
  # The body is empty by default.
  # 
  # *Arguments*:
  # 
  # * `http_request`: HTTP request
  # * `body`: Content of the body
  fun http_request_set_body = sfHttpRequest_setBody(http_request: HttpRequest, body: UInt8*)
  
  # Destroy a HTTP response
  # 
  # *Arguments*:
  # 
  # * `http_response`: HTTP response to destroy
  fun http_response_destroy = sfHttpResponse_destroy(http_response: HttpResponse)
  
  # Get the value of a field of a HTTP response
  # 
  # If the field `field` is not found in the response header,
  # the empty string is returned. This function uses
  # case-insensitive comparisons.
  # 
  # *Arguments*:
  # 
  # * `http_response`: HTTP response
  # * `field`: Name of the field to get
  # 
  # *Returns*: Value of the field, or empty string if not found
  fun http_response_get_field = sfHttpResponse_getField(http_response: HttpResponse, field: UInt8*): UInt8*
  
  # Get the status code of a HTTP reponse
  # 
  # The status code should be the first thing to be checked
  # after receiving a response, it defines whether it is a
  # success, a failure or anything else (see the HttpStatus
  # enumeration).
  # 
  # *Arguments*:
  # 
  # * `http_response`: HTTP response
  # 
  # *Returns*: Status code of the response
  fun http_response_get_status = sfHttpResponse_getStatus(http_response: HttpResponse): HttpStatus
  
  # Get the major HTTP version number of a HTTP response
  # 
  # *Arguments*:
  # 
  # * `http_response`: HTTP response
  # 
  # *Returns*: Major HTTP version number
  fun http_response_get_major_version = sfHttpResponse_getMajorVersion(http_response: HttpResponse): Int32
  
  # Get the minor HTTP version number of a HTTP response
  # 
  # *Arguments*:
  # 
  # * `http_response`: HTTP response
  # 
  # *Returns*: Minor HTTP version number
  fun http_response_get_minor_version = sfHttpResponse_getMinorVersion(http_response: HttpResponse): Int32
  
  # Get the body of a HTTP response
  # 
  # The body of a response may contain:
  # - the requested page (for GET requests)
  # - a response from the server (for POST requests)
  # - nothing (for HEAD requests)
  # - an error message (in case of an error)
  # 
  # *Arguments*:
  # 
  # * `http_response`: HTTP response
  # 
  # *Returns*: The response body
  fun http_response_get_body = sfHttpResponse_getBody(http_response: HttpResponse): UInt8*
  
  # Create a new Http object
  # 
  # *Returns*: A new Http object
  fun http_create = sfHttp_create(): Http
  
  # Destroy a Http object
  # 
  # *Arguments*:
  # 
  # * `http`: Http object to destroy
  fun http_destroy = sfHttp_destroy(http: Http)
  
  # Set the target host of a HTTP object
  # 
  # This function just stores the host address and port, it
  # doesn't actually connect to it until you send a request.
  # If the port is 0, it means that the HTTP client will use
  # the right port according to the protocol used
  # (80 for HTTP, 443 for HTTPS). You should
  # leave it like this unless you really need a port other
  # than the standard one, or use an unknown protocol.
  # 
  # *Arguments*:
  # 
  # * `http`: Http object
  # * `host`: Web server to connect to
  # * `port`: Port to use for connection
  fun http_set_host = sfHttp_setHost(http: Http, host: UInt8*, port: UInt16)
  
  # Send a HTTP request and return the server's response.
  # 
  # You must have a valid host before sending a request (see Http_setHost).
  # Any missing mandatory header field in the request will be added
  # with an appropriate value.
  # Warning: this function waits for the server's response and may
  # not return instantly; use a thread if you don't want to block your
  # application, or use a timeout to limit the time to wait. A value
  # of 0 means that the client will use the system defaut timeout
  # (which is usually pretty long).
  # 
  # *Arguments*:
  # 
  # * `http`: Http object
  # * `request`: Request to send
  # * `timeout`: Maximum time to wait
  # 
  # *Returns*: Server's response
  fun http_send_request = sfHttp_sendRequest(http: Http, request: HttpRequest, timeout: Time): HttpResponse
  
  # Create a new packet
  # 
  # *Returns*: A new Packet object
  fun packet_create = sfPacket_create(): Packet
  
  # Create a new packet by copying an existing one
  # 
  # *Arguments*:
  # 
  # * `packet`: Packet to copy
  # 
  # *Returns*: A new Packet object which is a copy of `packet`
  fun packet_copy = sfPacket_copy(packet: Packet): Packet
  
  # Destroy a packet
  # 
  # *Arguments*:
  # 
  # * `packet`: Packet to destroy
  fun packet_destroy = sfPacket_destroy(packet: Packet)
  
  # Append data to the end of a packet
  # 
  # *Arguments*:
  # 
  # * `packet`: Packet object
  # * `data`: Pointer to the sequence of bytes to append
  # * `size_in_bytes`: Number of bytes to append
  fun packet_append = sfPacket_append(packet: Packet, data: Void*, size_in_bytes: LibC::SizeT)
  
  # Clear a packet
  # 
  # After calling Clear, the packet is empty.
  # 
  # *Arguments*:
  # 
  # * `packet`: Packet object
  fun packet_clear = sfPacket_clear(packet: Packet)
  
  # Get a pointer to the data contained in a packet
  # 
  # Warning: the returned pointer may become invalid after
  # you append data to the packet, therefore it should never
  # be stored.
  # The return pointer is NULL if the packet is empty.
  # 
  # *Arguments*:
  # 
  # * `packet`: Packet object
  # 
  # *Returns*: Pointer to the data
  fun packet_get_data = sfPacket_getData(packet: Packet): Void*
  
  # Get the size of the data contained in a packet
  # 
  # This function returns the number of bytes pointed to by
  # what Packet_getData returns.
  # 
  # *Arguments*:
  # 
  # * `packet`: Packet object
  # 
  # *Returns*: Data size, in bytes
  fun packet_get_data_size = sfPacket_getDataSize(packet: Packet): LibC::SizeT
  
  # Tell if the reading position has reached the
  # end of a packet
  # 
  # This function is useful to know if there is some data
  # left to be read, without actually reading it.
  # 
  # *Arguments*:
  # 
  # * `packet`: Packet object
  # 
  # *Returns*: True if all data was read, False otherwise
  fun packet_end_of_packet = sfPacket_endOfPacket(packet: Packet): CSFML::Bool
  
  # Test the validity of a packet, for reading
  # 
  # This function allows to test the packet, to check if
  # a reading operation was successful.
  # 
  # A packet will be in an invalid state if it has no more
  # data to read.
  # 
  # *Arguments*:
  # 
  # * `packet`: Packet object
  # 
  # *Returns*: True if last data extraction from packet was successful
  fun packet_can_read = sfPacket_canRead(packet: Packet): CSFML::Bool
  
  # Functions to extract data from a packet
  # 
  # *Arguments*:
  # 
  # * `packet`: Packet object
  fun packet_read_bool = sfPacket_readBool(packet: Packet): CSFML::Bool
  
  fun packet_read_int8 = sfPacket_readInt8(packet: Packet): Int8
  
  fun packet_read_uint8 = sfPacket_readUint8(packet: Packet): UInt8
  
  fun packet_read_int16 = sfPacket_readInt16(packet: Packet): Int16
  
  fun packet_read_uint16 = sfPacket_readUint16(packet: Packet): UInt16
  
  fun packet_read_int32 = sfPacket_readInt32(packet: Packet): Int32
  
  fun packet_read_uint32 = sfPacket_readUint32(packet: Packet): UInt32
  
  fun packet_read_float = sfPacket_readFloat(packet: Packet): Float32
  
  fun packet_read_double = sfPacket_readDouble(packet: Packet): Float64
  
  fun packet_read_string = sfPacket_readString(packet: Packet, string: UInt8*)
  
  # Functions to insert data into a packet
  # 
  # *Arguments*:
  # 
  # * `packet`: Packet object
  fun packet_write_bool = sfPacket_writeBool(packet: Packet, p1: CSFML::Bool)
  
  fun packet_write_int8 = sfPacket_writeInt8(packet: Packet, p1: Int8)
  
  fun packet_write_uint8 = sfPacket_writeUint8(packet: Packet, p1: UInt8)
  
  fun packet_write_int16 = sfPacket_writeInt16(packet: Packet, p1: Int16)
  
  fun packet_write_uint16 = sfPacket_writeUint16(packet: Packet, p1: UInt16)
  
  fun packet_write_int32 = sfPacket_writeInt32(packet: Packet, p1: Int32)
  
  fun packet_write_uint32 = sfPacket_writeUint32(packet: Packet, p1: UInt32)
  
  fun packet_write_float = sfPacket_writeFloat(packet: Packet, p1: Float32)
  
  fun packet_write_double = sfPacket_writeDouble(packet: Packet, p1: Float64)
  
  fun packet_write_string = sfPacket_writeString(packet: Packet, string: UInt8*)
  
  # Create a new selector
  # 
  # *Returns*: A new SocketSelector object
  fun socket_selector_create = sfSocketSelector_create(): SocketSelector
  
  # Create a new socket selector by copying an existing one
  # 
  # *Arguments*:
  # 
  # * `selector`: Socket selector to copy
  # 
  # *Returns*: A new SocketSelector object which is a copy of `selector`
  fun socket_selector_copy = sfSocketSelector_copy(selector: SocketSelector): SocketSelector
  
  # Destroy a socket selector
  # 
  # *Arguments*:
  # 
  # * `selector`: Socket selector to destroy
  fun socket_selector_destroy = sfSocketSelector_destroy(selector: SocketSelector)
  
  # Add a new socket to a socket selector
  # 
  # This function keeps a weak pointer to the socket,
  # so you have to make sure that the socket is not destroyed
  # while it is stored in the selector.
  # 
  # *Arguments*:
  # 
  # * `selector`: Socket selector object
  # * `socket`: Pointer to the socket to add
  fun socket_selector_add_tcp_listener = sfSocketSelector_addTcpListener(selector: SocketSelector, socket: TcpListener)
  
  fun socket_selector_add_tcp_socket = sfSocketSelector_addTcpSocket(selector: SocketSelector, socket: TcpSocket)
  
  fun socket_selector_add_udp_socket = sfSocketSelector_addUdpSocket(selector: SocketSelector, socket: UdpSocket)
  
  # Remove a socket from a socket selector
  # 
  # This function doesn't destroy the socket, it simply
  # removes the pointer that the selector has to it.
  # 
  # *Arguments*:
  # 
  # * `selector`: Socket selector object
  # * `socket`: POointer to the socket to remove
  fun socket_selector_remove_tcp_listener = sfSocketSelector_removeTcpListener(selector: SocketSelector, socket: TcpListener)
  
  fun socket_selector_remove_tcp_socket = sfSocketSelector_removeTcpSocket(selector: SocketSelector, socket: TcpSocket)
  
  fun socket_selector_remove_udp_socket = sfSocketSelector_removeUdpSocket(selector: SocketSelector, socket: UdpSocket)
  
  # Remove all the sockets stored in a selector
  # 
  # This function doesn't destroy any instance, it simply
  # removes all the pointers that the selector has to
  # external sockets.
  # 
  # *Arguments*:
  # 
  # * `selector`: Socket selector object
  fun socket_selector_clear = sfSocketSelector_clear(selector: SocketSelector)
  
  # Wait until one or more sockets are ready to receive
  # 
  # This function returns as soon as at least one socket has
  # some data available to be received. To know which sockets are
  # ready, use the SocketSelector_isXxxReady functions.
  # If you use a timeout and no socket is ready before the timeout
  # is over, the function returns False.
  # 
  # *Arguments*:
  # 
  # * `selector`: Socket selector object
  # * `timeout`: Maximum time to wait (use TimeZero for infinity)
  # 
  # *Returns*: True if there are sockets ready, False otherwise
  fun socket_selector_wait = sfSocketSelector_wait(selector: SocketSelector, timeout: Time): CSFML::Bool
  
  # Test a socket to know if it is ready to receive data
  # 
  # This function must be used after a call to
  # SocketSelector_wait, to know which sockets are ready to
  # receive data. If a socket is ready, a call to Receive will
  # never block because we know that there is data available to read.
  # Note that if this function returns True for a TcpListener,
  # this means that it is ready to accept a new connection.
  # 
  # *Arguments*:
  # 
  # * `selector`: Socket selector object
  # * `socket`: Socket to test
  # 
  # *Returns*: True if the socket is ready to read, False otherwise
  fun socket_selector_is_tcp_listener_ready = sfSocketSelector_isTcpListenerReady(selector: SocketSelector, socket: TcpListener): CSFML::Bool
  
  fun socket_selector_is_tcp_socket_ready = sfSocketSelector_isTcpSocketReady(selector: SocketSelector, socket: TcpSocket): CSFML::Bool
  
  fun socket_selector_is_udp_socket_ready = sfSocketSelector_isUdpSocketReady(selector: SocketSelector, socket: UdpSocket): CSFML::Bool
  
  # Define the status that can be returned by the socket functions
  enum SocketStatus
    Done, NotReady, Partial, Disconnected, Error
  end
  
  # Create a new TCP listener
  # 
  # *Returns*: A new TcpListener object
  fun tcp_listener_create = sfTcpListener_create(): TcpListener
  
  # Destroy a TCP listener
  # 
  # *Arguments*:
  # 
  # * `listener`: TCP listener to destroy
  fun tcp_listener_destroy = sfTcpListener_destroy(listener: TcpListener)
  
  # Set the blocking state of a TCP listener
  # 
  # In blocking mode, calls will not return until they have
  # completed their task. For example, a call to
  # TcpListener_accept in blocking mode won't return until
  # a new connection was actually received.
  # In non-blocking mode, calls will always return immediately,
  # using the return code to signal whether there was data
  # available or not.
  # By default, all sockets are blocking.
  # 
  # *Arguments*:
  # 
  # * `listener`: TCP listener object
  # * `blocking`: True to set the socket as blocking, False for non-blocking
  fun tcp_listener_set_blocking = sfTcpListener_setBlocking(listener: TcpListener, blocking: CSFML::Bool)
  
  # Tell whether a TCP listener is in blocking or non-blocking mode
  # 
  # *Arguments*:
  # 
  # * `listener`: TCP listener object
  # 
  # *Returns*: True if the socket is blocking, False otherwise
  fun tcp_listener_is_blocking = sfTcpListener_isBlocking(listener: TcpListener): CSFML::Bool
  
  # Get the port to which a TCP listener is bound locally
  # 
  # If the socket is not listening to a port, this function
  # returns 0.
  # 
  # *Arguments*:
  # 
  # * `listener`: TCP listener object
  # 
  # *Returns*: Port to which the TCP listener is bound
  fun tcp_listener_get_local_port = sfTcpListener_getLocalPort(listener: TcpListener): UInt16
  
  # Start listening for connections
  # 
  # This functions makes the socket listen to the specified
  # port, waiting for new connections.
  # If the socket was previously listening to another port,
  # it will be stopped first and bound to the new port.
  # 
  # *Arguments*:
  # 
  # * `listener`: TCP listener object
  # * `port`: Port to listen for new connections
  # 
  # *Returns*: Status code
  fun tcp_listener_listen = sfTcpListener_listen(listener: TcpListener, port: UInt16): SocketStatus
  
  # Accept a new connection
  # 
  # If the socket is in blocking mode, this function will
  # not return until a connection is actually received.
  # 
  # The `connected` argument points to a valid TcpSocket pointer
  # in case of success (the function returns SocketDone), it points
  # to a NULL pointer otherwise.
  # 
  # *Arguments*:
  # 
  # * `listener`: TCP listener object
  # * `connected`: Socket that will hold the new connection
  # 
  # *Returns*: Status code
  fun tcp_listener_accept = sfTcpListener_accept(listener: TcpListener, connected: TcpSocket*): SocketStatus
  
  # Create a new TCP socket
  # 
  # *Returns*: A new TcpSocket object
  fun tcp_socket_create = sfTcpSocket_create(): TcpSocket
  
  # Destroy a TCP socket
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket to destroy
  fun tcp_socket_destroy = sfTcpSocket_destroy(socket: TcpSocket)
  
  # Set the blocking state of a TCP listener
  # 
  # In blocking mode, calls will not return until they have
  # completed their task. For example, a call to
  # TcpSocket_receive in blocking mode won't return until
  # new data was actually received.
  # In non-blocking mode, calls will always return immediately,
  # using the return code to signal whether there was data
  # available or not.
  # By default, all sockets are blocking.
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  # * `blocking`: True to set the socket as blocking, False for non-blocking
  fun tcp_socket_set_blocking = sfTcpSocket_setBlocking(socket: TcpSocket, blocking: CSFML::Bool)
  
  # Tell whether a TCP socket is in blocking or non-blocking mode
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  # 
  # *Returns*: True if the socket is blocking, False otherwise
  fun tcp_socket_is_blocking = sfTcpSocket_isBlocking(socket: TcpSocket): CSFML::Bool
  
  # Get the port to which a TCP socket is bound locally
  # 
  # If the socket is not connected, this function returns 0.
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  # 
  # *Returns*: Port to which the socket is bound
  fun tcp_socket_get_local_port = sfTcpSocket_getLocalPort(socket: TcpSocket): UInt16
  
  # Get the address of the connected peer of a TCP socket
  # 
  # It the socket is not connected, this function returns
  # IpAddress_None.
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  # 
  # *Returns*: Address of the remote peer
  fun tcp_socket_get_remote_address = sfTcpSocket_getRemoteAddress(socket: TcpSocket): IpAddress
  
  # Get the port of the connected peer to which
  # a TCP socket is connected
  # 
  # If the socket is not connected, this function returns 0.
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  # 
  # *Returns*: Remote port to which the socket is connected
  fun tcp_socket_get_remote_port = sfTcpSocket_getRemotePort(socket: TcpSocket): UInt16
  
  # Connect a TCP socket to a remote peer
  # 
  # In blocking mode, this function may take a while, especially
  # if the remote peer is not reachable. The last parameter allows
  # you to stop trying to connect after a given timeout.
  # If the socket was previously connected, it is first disconnected.
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  # * `remote_address`: Address of the remote peer
  # * `remote_port`: Port of the remote peer
  # * `timeout`: Maximum time to wait
  # 
  # *Returns*: Status code
  fun tcp_socket_connect = sfTcpSocket_connect(socket: TcpSocket, host: IpAddress, port: UInt16, timeout: Time): SocketStatus
  
  # Disconnect a TCP socket from its remote peer
  # 
  # This function gracefully closes the connection. If the
  # socket is not connected, this function has no effect.
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  fun tcp_socket_disconnect = sfTcpSocket_disconnect(socket: TcpSocket)
  
  # Send raw data to the remote peer of a TCP socket
  # 
  # To be able to handle partial sends over non-blocking
  # sockets, use the TcpSocket_sendPartial(TcpSocket*, const void*, std::size_t, size_t*)
  # overload instead.
  # This function will fail if the socket is not connected.
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  # * `data`: Pointer to the sequence of bytes to send
  # * `size`: Number of bytes to send
  # 
  # *Returns*: Status code
  fun tcp_socket_send = sfTcpSocket_send(socket: TcpSocket, data: Void*, size: LibC::SizeT): SocketStatus
  
  # Send raw data to the remote peer
  # 
  # This function will fail if the socket is not connected.
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  # * `data`: Pointer to the sequence of bytes to send
  # * `size`: Number of bytes to send
  # * `sent`: The number of bytes sent will be written here
  # 
  # *Returns*: Status code
  fun tcp_socket_send_partial = sfTcpSocket_sendPartial(socket: TcpSocket, data: Void*, size: LibC::SizeT, sent: LibC::SizeT*): SocketStatus
  
  # Receive raw data from the remote peer of a TCP socket
  # 
  # In blocking mode, this function will wait until some
  # bytes are actually received.
  # This function will fail if the socket is not connected.
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  # * `data`: Pointer to the array to fill with the received bytes
  # * `size`: Maximum number of bytes that can be received
  # * `received`: This variable is filled with the actual number of bytes received
  # 
  # *Returns*: Status code
  fun tcp_socket_receive = sfTcpSocket_receive(socket: TcpSocket, data: Void*, max_size: LibC::SizeT, size_received: LibC::SizeT*): SocketStatus
  
  # Send a formatted packet of data to the remote peer of a TCP socket
  # 
  # In non-blocking mode, if this function returns SocketPartial,
  # you must retry sending the same unmodified packet before sending
  # anything else in order to guarantee the packet arrives at the remote
  # peer uncorrupted.
  # This function will fail if the socket is not connected.
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  # * `packet`: Packet to send
  # 
  # *Returns*: Status code
  fun tcp_socket_send_packet = sfTcpSocket_sendPacket(socket: TcpSocket, packet: Packet): SocketStatus
  
  # Receive a formatted packet of data from the remote peer
  # 
  # In blocking mode, this function will wait until the whole packet
  # has been received.
  # This function will fail if the socket is not connected.
  # 
  # *Arguments*:
  # 
  # * `socket`: TCP socket object
  # * `packet`: Packet to fill with the received data
  # 
  # *Returns*: Status code
  fun tcp_socket_receive_packet = sfTcpSocket_receivePacket(socket: TcpSocket, packet: Packet): SocketStatus
  
  # Create a new UDP socket
  # 
  # *Returns*: A new UdpSocket object
  fun udp_socket_create = sfUdpSocket_create(): UdpSocket
  
  # Destroy a UDP socket
  # 
  # *Arguments*:
  # 
  # * `socket`: UDP socket to destroy
  fun udp_socket_destroy = sfUdpSocket_destroy(socket: UdpSocket)
  
  # Set the blocking state of a UDP listener
  # 
  # In blocking mode, calls will not return until they have
  # completed their task. For example, a call to
  # UDPSocket_receive in blocking mode won't return until
  # new data was actually received.
  # In non-blocking mode, calls will always return immediately,
  # using the return code to signal whether there was data
  # available or not.
  # By default, all sockets are blocking.
  # 
  # *Arguments*:
  # 
  # * `socket`: UDP socket object
  # * `blocking`: True to set the socket as blocking, False for non-blocking
  fun udp_socket_set_blocking = sfUdpSocket_setBlocking(socket: UdpSocket, blocking: CSFML::Bool)
  
  # Tell whether a UDP socket is in blocking or non-blocking mode
  # 
  # *Arguments*:
  # 
  # * `socket`: UDP socket object
  # 
  # *Returns*: True if the socket is blocking, False otherwise
  fun udp_socket_is_blocking = sfUdpSocket_isBlocking(socket: UdpSocket): CSFML::Bool
  
  # Get the port to which a UDP socket is bound locally
  # 
  # If the socket is not bound to a port, this function
  # returns 0.
  # 
  # *Arguments*:
  # 
  # * `socket`: UDP socket object
  # 
  # *Returns*: Port to which the socket is bound
  fun udp_socket_get_local_port = sfUdpSocket_getLocalPort(socket: UdpSocket): UInt16
  
  # Bind a UDP socket to a specific port
  # 
  # Binding the socket to a port is necessary for being
  # able to receive data on that port.
  # You can use the special value 0 to tell the
  # system to automatically pick an available port, and then
  # call UdpSocket_getLocalPort to retrieve the chosen port.
  # 
  # *Arguments*:
  # 
  # * `socket`: UDP socket object
  # * `port`: Port to bind the socket to
  # 
  # *Returns*: Status code
  fun udp_socket_bind = sfUdpSocket_bind(socket: UdpSocket, port: UInt16): SocketStatus
  
  # Unbind a UDP socket from the local port to which it is bound
  # 
  # The port that the socket was previously using is immediately
  # available after this function is called. If the
  # socket is not bound to a port, this function has no effect.
  # 
  # *Arguments*:
  # 
  # * `socket`: UDP socket object
  fun udp_socket_unbind = sfUdpSocket_unbind(socket: UdpSocket)
  
  # Send raw data to a remote peer with a UDP socket
  # 
  # Make sure that `size` is not greater than
  # UdpSocket_maxDatagramSize(), otherwise this function will
  # fail and no data will be sent.
  # 
  # *Arguments*:
  # 
  # * `socket`: UDP socket object
  # * `data`: Pointer to the sequence of bytes to send
  # * `size`: Number of bytes to send
  # * `remote_address`: Address of the receiver
  # * `remote_port`: Port of the receiver to send the data to
  # 
  # *Returns*: Status code
  fun udp_socket_send = sfUdpSocket_send(socket: UdpSocket, data: Void*, size: LibC::SizeT, address: IpAddress, port: UInt16): SocketStatus
  
  # Receive raw data from a remote peer with a UDP socket
  # 
  # In blocking mode, this function will wait until some
  # bytes are actually received.
  # Be careful to use a buffer which is large enough for
  # the data that you intend to receive, if it is too small
  # then an error will be returned and *all* the data will
  # be lost.
  # 
  # *Arguments*:
  # 
  # * `socket`: UDP socket object
  # * `data`: Pointer to the array to fill with the received bytes
  # * `size`: Maximum number of bytes that can be received
  # * `received`: This variable is filled with the actual number of bytes received
  # * `remote_address`: Address of the peer that sent the data
  # * `remote_port`: Port of the peer that sent the data
  # 
  # *Returns*: Status code
  fun udp_socket_receive = sfUdpSocket_receive(socket: UdpSocket, data: Void*, max_size: LibC::SizeT, size_received: LibC::SizeT*, address: IpAddress*, port: UInt16*): SocketStatus
  
  # Send a formatted packet of data to a remote peer with a UDP socket
  # 
  # Make sure that the packet size is not greater than
  # UdpSocket_maxDatagramSize(), otherwise this function will
  # fail and no data will be sent.
  # 
  # *Arguments*:
  # 
  # * `socket`: UDP socket object
  # * `packet`: Packet to send
  # * `remote_address`: Address of the receiver
  # * `remote_port`: Port of the receiver to send the data to
  # 
  # *Returns*: Status code
  fun udp_socket_send_packet = sfUdpSocket_sendPacket(socket: UdpSocket, packet: Packet, address: IpAddress, port: UInt16): SocketStatus
  
  # Receive a formatted packet of data from a remote peer with a UDP socket
  # 
  # In blocking mode, this function will wait until the whole packet
  # has been received.
  # 
  # *Arguments*:
  # 
  # * `packet`: Packet to fill with the received data
  # * `remote_address`: Address of the peer that sent the data
  # * `remote_port`: Port of the peer that sent the data
  # 
  # *Returns*: Status code
  fun udp_socket_receive_packet = sfUdpSocket_receivePacket(socket: UdpSocket, packet: Packet, address: IpAddress*, port: UInt16*): SocketStatus
  
  # Return the maximum number of bytes that can be
  # sent in a single UDP datagram
  # 
  # *Returns*: The maximum size of a UDP datagram (message)
  fun udp_socket_max_datagram_size = sfUdpSocket_maxDatagramSize(): Int32
  
end
