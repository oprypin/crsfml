require "./lib"
require "../common"
require "../system"
module SF
  extend self
  # Base class for all the socket types
  #
  # This class mainly defines internal stuff to be used by
  # derived classes.
  #
  # The only public features that it defines, and which
  # is therefore common to all the socket classes, is the
  # blocking state. All sockets can be set as blocking or
  # non-blocking.
  #
  # In blocking mode, socket functions will hang until
  # the operation completes, which means that the entire
  # program (well, in fact the current thread if you use
  # multiple ones) will be stuck waiting for your socket
  # operation to complete.
  #
  # In non-blocking mode, all the socket functions will
  # return immediately. If the socket is not ready to complete
  # the requested operation, the function simply returns
  # the proper status code (Socket::NotReady).
  #
  # The default mode, which is blocking, is the one that is
  # generally used, in combination with threads or selectors.
  # The non-blocking mode is rather used in real-time
  # applications that run an endless loop that can poll
  # the socket often enough, and cannot afford blocking
  # this loop.
  #
  # *See also:* `SF::TcpListener`, `SF::TcpSocket`, `SF::UdpSocket`
  class Socket
    @this : Void*
    # Status codes that may be returned by socket functions
    enum Status
      # The socket has sent / received the data
      Done
      # The socket is not ready to send / receive data yet
      NotReady
      # The socket sent a part of the data
      Partial
      # The TCP socket has been disconnected
      Disconnected
      # An unexpected error happened
      Error
    end
    Util.extract Socket::Status
    # Special value that tells the system to pick any available port
    AnyPort = 0
    # Destructor
    def finalize()
      SFMLExt.sfml_socket_finalize(to_unsafe)
      SFMLExt.sfml_socket_free(@this)
    end
    # Set the blocking state of the socket
    #
    # In blocking mode, calls will not return until they have
    # completed their task. For example, a call to Receive in
    # blocking mode won't return until some data was actually
    # received.
    # In non-blocking mode, calls will always return immediately,
    # using the return code to signal whether there was data
    # available or not.
    # By default, all sockets are blocking.
    #
    # * *blocking* - True to set the socket as blocking, false for non-blocking
    #
    # *See also:* `blocking?`
    def blocking=(blocking : Bool)
      SFMLExt.sfml_socket_setblocking_GZq(to_unsafe, blocking)
    end
    # Tell whether the socket is in blocking or non-blocking mode
    #
    # *Returns:* True if the socket is blocking, false otherwise
    #
    # *See also:* `blocking=`
    def blocking?() : Bool
      SFMLExt.sfml_socket_isblocking(to_unsafe, out result)
      return result
    end
    # Types of protocols that the socket can use
    enum Type
      # TCP protocol
      Tcp
      # UDP protocol
      Udp
    end
    Util.extract Socket::Type
    # Default constructor
    #
    # This constructor can only be accessed by derived classes.
    #
    # * *type* - Type of the socket (TCP or UDP)
    protected def initialize(type : Socket::Type)
      SFMLExt.sfml_socket_allocate(out @this)
      SFMLExt.sfml_socket_initialize_Wi8(to_unsafe, type)
    end
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Specialized socket using the TCP protocol
  #
  # TCP is a connected protocol, which means that a TCP
  # socket can only communicate with the host it is connected
  # to. It can't send or receive anything if it is not connected.
  #
  # The TCP protocol is reliable but adds a slight overhead.
  # It ensures that your data will always be received in order
  # and without errors (no data corrupted, lost or duplicated).
  #
  # When a socket is connected to a remote host, you can
  # retrieve informations about this host with the
  # remote_address and remote_port functions. You can
  # also get the local port to which the socket is bound
  # (which is automatically chosen when the socket is connected),
  # with the local_port function.
  #
  # Sending and receiving data can use either the low-level
  # or the high-level functions. The low-level functions
  # process a raw sequence of bytes, and cannot ensure that
  # one call to Send will exactly match one call to Receive
  # at the other end of the socket.
  #
  # The high-level interface uses packets (see `SF::Packet`),
  # which are easier to use and provide more safety regarding
  # the data that is exchanged. You can look at the `SF::Packet`
  # class to get more details about how they work.
  #
  # The socket is automatically disconnected when it is destroyed,
  # but if you want to explicitly close the connection while
  # the socket instance is still alive, you can call disconnect.
  #
  # Usage example:
  # ```crystal
  # # ----- The client -----
  #
  # # Create a socket and connect it to 192.168.1.50 on port 55001
  # socket = SF::TcpSocket.new
  # socket.connect("192.168.1.50", 55001)
  #
  # # Send a message to the connected host
  # message = "Hi, I am a client"
  # socket.send(message.to_slice)
  #
  # # Receive an answer from the server
  # buffer = Slice(UInt8).new(1024)
  # status, received = socket.receive(buffer)
  # puts "The server said: #{buffer}"
  #
  # # ----- The server -----
  #
  # # Create a listener to wait for incoming connections on port 55001
  # listener = SF::TcpListener.new
  # listener.listen(55001)
  #
  # # Wait for a connection
  # socket = SF::TcpSocket.new
  # listener.accept(socket)
  # puts "New client connected: #{socket.remote_address}"
  #
  # # Receive a message from the client
  # buffer = Slice(UInt8).new(1024)
  # status, received = socket.receive(buffer)
  # puts "The client said: #{buffer}"
  #
  # # Send an answer
  # message = "Welcome, client"
  # socket.send(message.to_slice)
  # ```
  #
  # *See also:* `SF::Socket`, `SF::UdpSocket`, `SF::Packet`
  class TcpSocket < Socket
    @this : Void*
    def finalize()
      SFMLExt.sfml_tcpsocket_finalize(to_unsafe)
      SFMLExt.sfml_tcpsocket_free(@this)
    end
    # Default constructor
    def initialize()
      SFMLExt.sfml_tcpsocket_allocate(out @this)
      SFMLExt.sfml_tcpsocket_initialize(to_unsafe)
    end
    # Get the port to which the socket is bound locally
    #
    # If the socket is not connected, this function returns 0.
    #
    # *Returns:* Port to which the socket is bound
    #
    # *See also:* `connect`, `remote_port`
    def local_port() : UInt16
      SFMLExt.sfml_tcpsocket_getlocalport(to_unsafe, out result)
      return result
    end
    # Get the address of the connected peer
    #
    # It the socket is not connected, this function returns
    # `SF::IpAddress::None`.
    #
    # *Returns:* Address of the remote peer
    #
    # *See also:* `remote_port`
    def remote_address() : IpAddress
      result = IpAddress.allocate
      SFMLExt.sfml_tcpsocket_getremoteaddress(to_unsafe, result)
      return result
    end
    # Get the port of the connected peer to which
    # the socket is connected
    #
    # If the socket is not connected, this function returns 0.
    #
    # *Returns:* Remote port to which the socket is connected
    #
    # *See also:* `remote_address`
    def remote_port() : UInt16
      SFMLExt.sfml_tcpsocket_getremoteport(to_unsafe, out result)
      return result
    end
    # Connect the socket to a remote peer
    #
    # In blocking mode, this function may take a while, especially
    # if the remote peer is not reachable. The last parameter allows
    # you to stop trying to connect after a given timeout.
    # If the socket is already connected, the connection is
    # forcibly disconnected before attempting to connect again.
    #
    # * *remote_address* - Address of the remote peer
    # * *remote_port* - Port of the remote peer
    # * *timeout* - Optional maximum time to wait
    #
    # *Returns:* Status code
    #
    # *See also:* `disconnect`
    def connect(remote_address : IpAddress, remote_port : Int, timeout : Time = Time::Zero) : Socket::Status
      SFMLExt.sfml_tcpsocket_connect_BfEbxif4T(to_unsafe, remote_address, LibC::UShort.new(remote_port), timeout, out result)
      return Socket::Status.new(result)
    end
    # Disconnect the socket from its remote peer
    #
    # This function gracefully closes the connection. If the
    # socket is not connected, this function has no effect.
    #
    # *See also:* `connect`
    def disconnect()
      SFMLExt.sfml_tcpsocket_disconnect(to_unsafe)
    end
    # Send raw data to the remote peer
    #
    # To be able to handle partial sends over non-blocking
    # sockets, use the send(const void*, std::size_t, std::size_t&)
    # overload instead.
    # This function will fail if the socket is not connected.
    #
    # * *data* - Pointer to the sequence of bytes to send
    # * *size* - Number of bytes to send
    #
    # *Returns:* Status code
    #
    # *See also:* `receive`
    def send(data : Slice) : Socket::Status
      SFMLExt.sfml_tcpsocket_send_5h8vgv(to_unsafe, data, data.bytesize, out result)
      return Socket::Status.new(result)
    end
    # Send raw data to the remote peer
    #
    # This function will fail if the socket is not connected.
    #
    # * *data* - Slice containing the bytes to send
    #
    # *Returns:*
    #
    # * Status code
    # * The number of bytes sent
    #
    # *See also:* `receive`
    def send(data : Slice) : {Socket::Status, Int32}
      SFMLExt.sfml_tcpsocket_send_5h8vgvi49(to_unsafe, data, data.bytesize, out sent, out result)
      return Socket::Status.new(result), sent.to_i
    end
    # Receive raw data from the remote peer
    #
    # In blocking mode, this function will wait until some
    # bytes are actually received.
    # This function will fail if the socket is not connected.
    #
    # * *data* - The slice to fill with the received bytes
    #
    # *Returns:*
    #
    # * Status code
    # * The actual number of bytes received
    #
    # *See also:* `send`
    def receive(data : Slice) : {Socket::Status, Int32}
      SFMLExt.sfml_tcpsocket_receive_xALvgvi49(to_unsafe, data, data.bytesize, out received, out result)
      return Socket::Status.new(result), received.to_i
    end
    # Send a formatted packet of data to the remote peer
    #
    # In non-blocking mode, if this function returns `SF::Socket::Partial`,
    # you *must* retry sending the same unmodified packet before sending
    # anything else in order to guarantee the packet arrives at the remote
    # peer uncorrupted.
    # This function will fail if the socket is not connected.
    #
    # * *packet* - Packet to send
    #
    # *Returns:* Status code
    #
    # *See also:* `receive`
    def send(packet : Packet) : Socket::Status
      SFMLExt.sfml_tcpsocket_send_jyF(to_unsafe, packet, out result)
      return Socket::Status.new(result)
    end
    # Receive a formatted packet of data from the remote peer
    #
    # In blocking mode, this function will wait until the whole packet
    # has been received.
    # This function will fail if the socket is not connected.
    #
    # * *packet* - Packet to fill with the received data
    #
    # *Returns:* Status code
    #
    # *See also:* `send`
    def receive(packet : Packet) : Socket::Status
      SFMLExt.sfml_tcpsocket_receive_jyF(to_unsafe, packet, out result)
      return Socket::Status.new(result)
    end
    # :nodoc:
    def blocking=(blocking : Bool)
      SFMLExt.sfml_tcpsocket_setblocking_GZq(to_unsafe, blocking)
    end
    # :nodoc:
    def blocking?() : Bool
      SFMLExt.sfml_tcpsocket_isblocking(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # A FTP client
  #
  # `SF::Ftp` is a very simple FTP client that allows you
  # to communicate with a FTP server. The FTP protocol allows
  # you to manipulate a remote file system (list files,
  # upload, download, create, remove, ...).
  #
  # Using the FTP client consists of 4 parts:
  #
  # * Connecting to the FTP server
  # * Logging in (either as a registered user or anonymously)
  # * Sending commands to the server
  # * Disconnecting (this part can be done implicitly by the destructor)
  #
  # Every command returns a FTP response, which contains the
  # status code as well as a message from the server. Some
  # commands such as `working_directory()` and `directory_listing()`
  # return additional data, and use a class derived from
  # `SF::Ftp::Response` to provide this data. The most often used
  # commands are directly provided as member functions, but it is
  # also possible to use specific commands with the `send_command()` function.
  #
  # Note that response statuses &gt;= 1000 are not part of the FTP standard,
  # they are generated by SFML when an internal error occurs.
  #
  # All commands, especially upload and download, may take some
  # time to complete. This is important to know if you don't want
  # to block your application while the server is completing
  # the task.
  #
  # Usage example:
  # ```crystal
  # # Create a new FTP client
  # ftp = SF::Ftp.new
  #
  # # Connect to the server
  # response = ftp.connect("ftp://ftp.myserver.com")
  # if response.ok?
  #   puts "Connected"
  # end
  #
  # # Log in
  # response = ftp.login("laurent", "dF6Zm89D")
  # if response.ok?
  #   puts "Logged in"
  # end
  #
  # # Print the working directory
  # directory = ftp.working_directory
  # if directory.ok?
  #   puts "Working directory: #{directory.directory}"
  # end
  #
  # # Create a new directory
  # response = ftp.create_directory "files"
  # if response.ok?
  #   puts "Created new directory"
  # end
  #
  # # Upload a file to this new directory
  # response = ftp.upload("local-path/file.txt", "files", SF::Ftp::Ascii)
  # if response.ok?
  #   puts "File uploaded"
  # end
  #
  # # Send specific commands (here: FEAT to list supported FTP features)
  # response = ftp.send_command "FEAT"
  # if response.ok?
  #   puts "Feature list:\n#{response.message}"
  # end
  #
  # # Disconnect from the server
  # ftp.disconnect
  # ```
  class Ftp
    @this : Void*
    def initialize()
      SFMLExt.sfml_ftp_allocate(out @this)
      SFMLExt.sfml_ftp_initialize(to_unsafe)
    end
    # Enumeration of transfer modes
    enum TransferMode
      # Binary mode (file is transfered as a sequence of bytes)
      Binary
      # Text mode using ASCII encoding
      Ascii
      # Text mode using EBCDIC encoding
      Ebcdic
    end
    Util.extract Ftp::TransferMode
    # Define a FTP response
    class Response
      @this : Void*
      def finalize()
        SFMLExt.sfml_ftp_response_finalize(to_unsafe)
        SFMLExt.sfml_ftp_response_free(@this)
      end
      # Status codes possibly returned by a FTP response
      enum Status
        # Restart marker reply
        RestartMarkerReply = 110
        # Service ready in N minutes
        ServiceReadySoon = 120
        # Data connection already opened, transfer starting
        DataConnectionAlreadyOpened = 125
        # File status ok, about to open data connection
        OpeningDataConnection = 150
        # Command ok
        Ok = 200
        # Command not implemented
        PointlessCommand = 202
        # System status, or system help reply
        SystemStatus = 211
        # Directory status
        DirectoryStatus = 212
        # File status
        FileStatus = 213
        # Help message
        HelpMessage = 214
        # NAME system type, where NAME is an official system name from the list in the Assigned Numbers document
        SystemType = 215
        # Service ready for new user
        ServiceReady = 220
        # Service closing control connection
        ClosingConnection = 221
        # Data connection open, no transfer in progress
        DataConnectionOpened = 225
        # Closing data connection, requested file action successful
        ClosingDataConnection = 226
        # Entering passive mode
        EnteringPassiveMode = 227
        # User logged in, proceed. Logged out if appropriate
        LoggedIn = 230
        # Requested file action ok
        FileActionOk = 250
        # PATHNAME created
        DirectoryOk = 257
        # User name ok, need password
        NeedPassword = 331
        # Need account for login
        NeedAccountToLogIn = 332
        # Requested file action pending further information
        NeedInformation = 350
        # Service not available, closing control connection
        ServiceUnavailable = 421
        # Can't open data connection
        DataConnectionUnavailable = 425
        # Connection closed, transfer aborted
        TransferAborted = 426
        # Requested file action not taken
        FileActionAborted = 450
        # Requested action aborted, local error in processing
        LocalError = 451
        # Requested action not taken; insufficient storage space in system, file unavailable
        InsufficientStorageSpace = 452
        # Syntax error, command unrecognized
        CommandUnknown = 500
        # Syntax error in parameters or arguments
        ParametersUnknown = 501
        # Command not implemented
        CommandNotImplemented = 502
        # Bad sequence of commands
        BadCommandSequence = 503
        # Command not implemented for that parameter
        ParameterNotImplemented = 504
        # Not logged in
        NotLoggedIn = 530
        # Need account for storing files
        NeedAccountToStore = 532
        # Requested action not taken, file unavailable
        FileUnavailable = 550
        # Requested action aborted, page type unknown
        PageTypeUnknown = 551
        # Requested file action aborted, exceeded storage allocation
        NotEnoughMemory = 552
        # Requested action not taken, file name not allowed
        FilenameNotAllowed = 553
        # Not part of the FTP standard, generated by SFML when a received response cannot be parsed
        InvalidResponse = 1000
        # Not part of the FTP standard, generated by SFML when the low-level socket connection with the server fails
        ConnectionFailed = 1001
        # Not part of the FTP standard, generated by SFML when the low-level socket connection is unexpectedly closed
        ConnectionClosed = 1002
        # Not part of the FTP standard, generated by SFML when a local file cannot be read or written
        InvalidFile = 1003
      end
      Util.extract Ftp::Response::Status
      # Default constructor
      #
      # This constructor is used by the FTP client to build
      # the response.
      #
      # * *code* - Response status code
      # * *message* - Response message
      def initialize(code : Ftp::Response::Status = InvalidResponse, message : String = "")
        SFMLExt.sfml_ftp_response_allocate(out @this)
        SFMLExt.sfml_ftp_response_initialize_nyWzkC(to_unsafe, code, message.bytesize, message)
      end
      # Check if the status code means a success
      #
      # This function is defined for convenience, it is
      # equivalent to testing if the status code is &lt; 400.
      #
      # *Returns:* True if the status is a success, false if it is a failure
      def ok?() : Bool
        SFMLExt.sfml_ftp_response_isok(to_unsafe, out result)
        return result
      end
      # Get the status code of the response
      #
      # *Returns:* Status code
      def status() : Ftp::Response::Status
        SFMLExt.sfml_ftp_response_getstatus(to_unsafe, out result)
        return Ftp::Response::Status.new(result)
      end
      # Get the full message contained in the response
      #
      # *Returns:* The response message
      def message() : String
        SFMLExt.sfml_ftp_response_getmessage(to_unsafe, out result)
        return String.new(result)
      end
      # :nodoc:
      def to_unsafe()
        @this
      end
      # :nodoc:
      def inspect(io)
        to_s(io)
      end
      # :nodoc:
      def initialize(copy : Ftp::Response)
        SFMLExt.sfml_ftp_response_allocate(out @this)
        SFMLExt.sfml_ftp_response_initialize_lXv(to_unsafe, copy)
      end
      def dup() : Response
        return Response.new(self)
      end
    end
    # Specialization of FTP response returning a directory
    class DirectoryResponse < Response
      @this : Void*
      def finalize()
        SFMLExt.sfml_ftp_directoryresponse_finalize(to_unsafe)
        SFMLExt.sfml_ftp_directoryresponse_free(@this)
      end
      # Default constructor
      #
      # * *response* - Source response
      def initialize(response : Ftp::Response)
        SFMLExt.sfml_ftp_directoryresponse_allocate(out @this)
        SFMLExt.sfml_ftp_directoryresponse_initialize_lXv(to_unsafe, response)
      end
      # Get the directory returned in the response
      #
      # *Returns:* Directory name
      def directory() : String
        SFMLExt.sfml_ftp_directoryresponse_getdirectory(to_unsafe, out result)
        return String.new(result)
      end
      # :nodoc:
      def ok?() : Bool
        SFMLExt.sfml_ftp_directoryresponse_isok(to_unsafe, out result)
        return result
      end
      # :nodoc:
      def status() : Ftp::Response::Status
        SFMLExt.sfml_ftp_directoryresponse_getstatus(to_unsafe, out result)
        return Ftp::Response::Status.new(result)
      end
      # :nodoc:
      def message() : String
        SFMLExt.sfml_ftp_directoryresponse_getmessage(to_unsafe, out result)
        return String.new(result)
      end
      # :nodoc:
      def inspect(io)
        to_s(io)
      end
      # :nodoc:
      def initialize(copy : Ftp::DirectoryResponse)
        SFMLExt.sfml_ftp_directoryresponse_allocate(out @this)
        SFMLExt.sfml_ftp_directoryresponse_initialize_Zyp(to_unsafe, copy)
      end
      def dup() : DirectoryResponse
        return DirectoryResponse.new(self)
      end
    end
    # Specialization of FTP response returning a
    # filename listing
    class ListingResponse < Response
      @this : Void*
      def finalize()
        SFMLExt.sfml_ftp_listingresponse_finalize(to_unsafe)
        SFMLExt.sfml_ftp_listingresponse_free(@this)
      end
      # Default constructor
      #
      # * *response* - Source response
      # * *data* - Data containing the raw listing
      def initialize(response : Ftp::Response, data : String)
        SFMLExt.sfml_ftp_listingresponse_allocate(out @this)
        SFMLExt.sfml_ftp_listingresponse_initialize_lXvzkC(to_unsafe, response, data.bytesize, data)
      end
      # Return the array of directory/file names
      #
      # *Returns:* Array containing the requested listing
      def listing() : Array(String)
        SFMLExt.sfml_ftp_listingresponse_getlisting(to_unsafe, out result, out result_size)
        return Array.new(result_size.to_i) { |i| String.new(result[i]) }
      end
      # :nodoc:
      def ok?() : Bool
        SFMLExt.sfml_ftp_listingresponse_isok(to_unsafe, out result)
        return result
      end
      # :nodoc:
      def status() : Ftp::Response::Status
        SFMLExt.sfml_ftp_listingresponse_getstatus(to_unsafe, out result)
        return Ftp::Response::Status.new(result)
      end
      # :nodoc:
      def message() : String
        SFMLExt.sfml_ftp_listingresponse_getmessage(to_unsafe, out result)
        return String.new(result)
      end
      # :nodoc:
      def inspect(io)
        to_s(io)
      end
      # :nodoc:
      def initialize(copy : Ftp::ListingResponse)
        SFMLExt.sfml_ftp_listingresponse_allocate(out @this)
        SFMLExt.sfml_ftp_listingresponse_initialize_2ho(to_unsafe, copy)
      end
      def dup() : ListingResponse
        return ListingResponse.new(self)
      end
    end
    # Destructor
    #
    # Automatically closes the connection with the server if
    # it is still opened.
    def finalize()
      SFMLExt.sfml_ftp_finalize(to_unsafe)
      SFMLExt.sfml_ftp_free(@this)
    end
    # Connect to the specified FTP server
    #
    # The port has a default value of 21, which is the standard
    # port used by the FTP protocol. You shouldn't use a different
    # value, unless you really know what you do.
    # This function tries to connect to the server so it may take
    # a while to complete, especially if the server is not
    # reachable. To avoid blocking your application for too long,
    # you can use a timeout. The default value, Time::Zero, means that the
    # system timeout will be used (which is usually pretty long).
    #
    # * *server* - Name or address of the FTP server to connect to
    # * *port* - Port used for the connection
    # * *timeout* - Maximum time to wait
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `disconnect`
    def connect(server : IpAddress, port : Int = 21, timeout : Time = Time::Zero) : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_connect_BfEbxif4T(to_unsafe, server, LibC::UShort.new(port), timeout, result)
      return result
    end
    # Close the connection with the server
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `connect`
    def disconnect() : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_disconnect(to_unsafe, result)
      return result
    end
    # Log in using an anonymous account
    #
    # Logging in is mandatory after connecting to the server.
    # Users that are not logged in cannot perform any operation.
    #
    # *Returns:* Server response to the request
    def login() : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_login(to_unsafe, result)
      return result
    end
    # Log in using a username and a password
    #
    # Logging in is mandatory after connecting to the server.
    # Users that are not logged in cannot perform any operation.
    #
    # * *name* - User name
    # * *password* - Password
    #
    # *Returns:* Server response to the request
    def login(name : String, password : String) : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_login_zkCzkC(to_unsafe, name.bytesize, name, password.bytesize, password, result)
      return result
    end
    # Send a null command to keep the connection alive
    #
    # This command is useful because the server may close the
    # connection automatically if no command is sent.
    #
    # *Returns:* Server response to the request
    def keep_alive() : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_keepalive(to_unsafe, result)
      return result
    end
    # Get the current working directory
    #
    # The working directory is the root path for subsequent
    # operations involving directories and/or filenames.
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `directory_listing`, `change_directory`, `parent_directory`
    def working_directory() : Ftp::DirectoryResponse
      result = Ftp::DirectoryResponse.new
      SFMLExt.sfml_ftp_getworkingdirectory(to_unsafe, result)
      return result
    end
    # Get the contents of the given directory
    #
    # This function retrieves the sub-directories and files
    # contained in the given directory. It is not recursive.
    # The *directory* parameter is relative to the current
    # working directory.
    #
    # * *directory* - Directory to list
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `working_directory`, `change_directory`, `parent_directory`
    def get_directory_listing(directory : String = "") : Ftp::ListingResponse
      result = Ftp::ListingResponse.new
      SFMLExt.sfml_ftp_getdirectorylisting_zkC(to_unsafe, directory.bytesize, directory, result)
      return result
    end
    # Change the current working directory
    #
    # The new directory must be relative to the current one.
    #
    # * *directory* - New working directory
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `working_directory`, `directory_listing`, `parent_directory`
    def change_directory(directory : String) : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_changedirectory_zkC(to_unsafe, directory.bytesize, directory, result)
      return result
    end
    # Go to the parent directory of the current one
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `working_directory`, `directory_listing`, `change_directory`
    def parent_directory() : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_parentdirectory(to_unsafe, result)
      return result
    end
    # Create a new directory
    #
    # The new directory is created as a child of the current
    # working directory.
    #
    # * *name* - Name of the directory to create
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `delete_directory`
    def create_directory(name : String) : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_createdirectory_zkC(to_unsafe, name.bytesize, name, result)
      return result
    end
    # Remove an existing directory
    #
    # The directory to remove must be relative to the
    # current working directory.
    # Use this function with caution, the directory will
    # be removed permanently!
    #
    # * *name* - Name of the directory to remove
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `create_directory`
    def delete_directory(name : String) : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_deletedirectory_zkC(to_unsafe, name.bytesize, name, result)
      return result
    end
    # Rename an existing file
    #
    # The filenames must be relative to the current working
    # directory.
    #
    # * *file* - File to rename
    # * *new_name* - New name of the file
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `delete_file`
    def rename_file(file : String, new_name : String) : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_renamefile_zkCzkC(to_unsafe, file.bytesize, file, new_name.bytesize, new_name, result)
      return result
    end
    # Remove an existing file
    #
    # The file name must be relative to the current working
    # directory.
    # Use this function with caution, the file will be
    # removed permanently!
    #
    # * *name* - File to remove
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `rename_file`
    def delete_file(name : String) : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_deletefile_zkC(to_unsafe, name.bytesize, name, result)
      return result
    end
    # Download a file from the server
    #
    # The filename of the distant file is relative to the
    # current working directory of the server, and the local
    # destination path is relative to the current directory
    # of your application.
    # If a file with the same filename as the distant file
    # already exists in the local destination path, it will
    # be overwritten.
    #
    # * *remote_file* - Filename of the distant file to download
    # * *local_path* - The directory in which to put the file on the local computer
    # * *mode* - Transfer mode
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `upload`
    def download(remote_file : String, local_path : String, mode : Ftp::TransferMode = Binary) : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_download_zkCzkCJP8(to_unsafe, remote_file.bytesize, remote_file, local_path.bytesize, local_path, mode, result)
      return result
    end
    # Upload a file to the server
    #
    # The name of the local file is relative to the current
    # working directory of your application, and the
    # remote path is relative to the current directory of the
    # FTP server.
    #
    # The append parameter controls whether the remote file is
    # appended to or overwritten if it already exists.
    #
    # * *local_file* - Path of the local file to upload
    # * *remote_path* - The directory in which to put the file on the server
    # * *mode* - Transfer mode
    # * *append* - Pass true to append to or false to overwrite the remote file if it already exists
    #
    # *Returns:* Server response to the request
    #
    # *See also:* `download`
    def upload(local_file : String, remote_path : String, mode : Ftp::TransferMode = Binary, append : Bool = false) : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_upload_zkCzkCJP8GZq(to_unsafe, local_file.bytesize, local_file, remote_path.bytesize, remote_path, mode, append, result)
      return result
    end
    # Send a command to the FTP server
    #
    # While the most often used commands are provided as member
    # functions in the `SF::Ftp` class, this method can be used
    # to send any FTP command to the server. If the command
    # requires one or more parameters, they can be specified
    # in *parameter*. If the server returns information, you
    # can extract it from the response using `Response.message()`.
    #
    # * *command* - Command to send
    # * *parameter* - Command parameter
    #
    # *Returns:* Server response to the request
    def send_command(command : String, parameter : String = "") : Ftp::Response
      result = Ftp::Response.new
      SFMLExt.sfml_ftp_sendcommand_zkCzkC(to_unsafe, command.bytesize, command, parameter.bytesize, parameter, result)
      return result
    end
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Encapsulate an IPv4 network address
  #
  # `SF::IpAddress` is a utility class for manipulating network
  # addresses. It provides a set a implicit constructors and
  # conversion functions to easily build or transform an IP
  # address from/to various representations.
  #
  # Usage example:
  # ```crystal
  # a0 = SF::IpAddress.new                   # an invalid address
  # a1 = SF::IpAddress::None                 # an invalid address (same as a0)
  # a2 = SF::IpAddress.new("127.0.0.1")      # the local host address
  # a3 = SF::IpAddress::Broadcast            # the broadcast address
  # a4 = SF::IpAddress.new(192, 168, 1, 56)  # a local address
  # a5 = SF::IpAddress.new("my_computer")    # a local address created from a network name
  # a6 = SF::IpAddress.new("89.54.1.169")    # a distant address
  # a7 = SF::IpAddress.new("www.google.com") # a distant address created from a network name
  # a8 = SF::IpAddress.local_address         # my address on the local network
  # a9 = SF::IpAddress.get_public_address    # my address on the internet
  # ```
  #
  # Note that `SF::IpAddress` currently doesn't support IPv6
  # nor other types of network addresses.
  struct IpAddress
    @address : UInt32
    @valid : Bool
    # Default constructor
    #
    # This constructor creates an empty (invalid) address
    def initialize()
      @address = uninitialized UInt32
      @valid = uninitialized Bool
      SFMLExt.sfml_ipaddress_initialize(to_unsafe)
    end
    # Construct the address from a string
    #
    # Here *address* can be either a decimal address
    # (ex: "192.168.1.56") or a network name (ex: "localhost").
    #
    # * *address* - IP address or network name
    def initialize(address : String)
      @address = uninitialized UInt32
      @valid = uninitialized Bool
      SFMLExt.sfml_ipaddress_initialize_zkC(to_unsafe, address.bytesize, address)
    end
    # Construct the address from a string
    #
    # Here *address* can be either a decimal address
    # (ex: "192.168.1.56") or a network name (ex: "localhost").
    # This is equivalent to the constructor taking a std::string
    # parameter, it is defined for convenience so that the
    # implicit conversions from literal strings to IpAddress work.
    #
    # * *address* - IP address or network name
    def initialize(address : String)
      @address = uninitialized UInt32
      @valid = uninitialized Bool
      SFMLExt.sfml_ipaddress_initialize_Yy6(to_unsafe, address)
    end
    # Construct the address from 4 bytes
    #
    # Calling IpAddress(a, b, c, d) is equivalent to calling
    # IpAddress("a.b.c.d"), but safer as it doesn't have to
    # parse a string to get the address components.
    #
    # * *byte0* - First byte of the address
    # * *byte1* - Second byte of the address
    # * *byte2* - Third byte of the address
    # * *byte3* - Fourth byte of the address
    def initialize(byte0 : Int, byte1 : Int, byte2 : Int, byte3 : Int)
      @address = uninitialized UInt32
      @valid = uninitialized Bool
      SFMLExt.sfml_ipaddress_initialize_9yU9yU9yU9yU(to_unsafe, UInt8.new(byte0), UInt8.new(byte1), UInt8.new(byte2), UInt8.new(byte3))
    end
    # Construct the address from a 32-bits integer
    #
    # This constructor uses the internal representation of
    # the address directly. It should be used for optimization
    # purposes, and only if you got that representation from
    # IpAddress.to_integer().
    #
    # * *address* - 4 bytes of the address packed into a 32-bits integer
    #
    # *See also:* `to_integer`
    def initialize(address : Int)
      @address = uninitialized UInt32
      @valid = uninitialized Bool
      SFMLExt.sfml_ipaddress_initialize_saL(to_unsafe, UInt32.new(address))
    end
    # Get a string representation of the address
    #
    # The returned string is the decimal representation of the
    # IP address (like "192.168.1.56"), even if it was constructed
    # from a host name.
    #
    # *Returns:* String representation of the address
    #
    # *See also:* `to_integer`
    def to_s() : String
      SFMLExt.sfml_ipaddress_tostring(to_unsafe, out result)
      return String.new(result)
    end
    # Get an integer representation of the address
    #
    # The returned number is the internal representation of the
    # address, and should be used for optimization purposes only
    # (like sending the address through a socket).
    # The integer produced by this function can then be converted
    # back to a `SF::IpAddress` with the proper constructor.
    #
    # *Returns:* 32-bits unsigned integer representation of the address
    #
    # *See also:* `to_s`
    def to_integer() : UInt32
      SFMLExt.sfml_ipaddress_tointeger(to_unsafe, out result)
      return result
    end
    # Get the computer's local address
    #
    # The local address is the address of the computer from the
    # LAN point of view, i.e. something like 192.168.1.56. It is
    # meaningful only for communications over the local network.
    # Unlike public_address, this function is fast and may be
    # used safely anywhere.
    #
    # *Returns:* Local IP address of the computer
    #
    # *See also:* `public_address`
    def self.local_address() : IpAddress
      result = IpAddress.allocate
      SFMLExt.sfml_ipaddress_getlocaladdress(result)
      return result
    end
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
    # to be possibly stuck waiting in case there is a problem; this
    # limit is deactivated by default.
    #
    # * *timeout* - Maximum time to wait
    #
    # *Returns:* Public IP address of the computer
    #
    # *See also:* `local_address`
    def self.get_public_address(timeout : Time = Time::Zero) : IpAddress
      result = IpAddress.allocate
      SFMLExt.sfml_ipaddress_getpublicaddress_f4T(timeout, result)
      return result
    end
    @address : UInt32
    @valid : Bool
    # Overload of == operator to compare two IP addresses
    #
    # * *left* - Left operand (a IP address)
    # * *right* - Right operand (a IP address)
    #
    # *Returns:* True if both addresses are equal
    def ==(right : IpAddress) : Bool
      SFMLExt.sfml_operator_eq_BfEBfE(to_unsafe, right, out result)
      return result
    end
    # Overload of != operator to compare two IP addresses
    #
    # * *left* - Left operand (a IP address)
    # * *right* - Right operand (a IP address)
    #
    # *Returns:* True if both addresses are different
    def !=(right : IpAddress) : Bool
      SFMLExt.sfml_operator_ne_BfEBfE(to_unsafe, right, out result)
      return result
    end
    # Overload of &lt; operator to compare two IP addresses
    #
    # * *left* - Left operand (a IP address)
    # * *right* - Right operand (a IP address)
    #
    # *Returns:* True if *left* is lesser than *right*
    def <(right : IpAddress) : Bool
      SFMLExt.sfml_operator_lt_BfEBfE(to_unsafe, right, out result)
      return result
    end
    # Overload of &gt; operator to compare two IP addresses
    #
    # * *left* - Left operand (a IP address)
    # * *right* - Right operand (a IP address)
    #
    # *Returns:* True if *left* is greater than *right*
    def >(right : IpAddress) : Bool
      SFMLExt.sfml_operator_gt_BfEBfE(to_unsafe, right, out result)
      return result
    end
    # Overload of &lt;= operator to compare two IP addresses
    #
    # * *left* - Left operand (a IP address)
    # * *right* - Right operand (a IP address)
    #
    # *Returns:* True if *left* is lesser or equal than *right*
    def <=(right : IpAddress) : Bool
      SFMLExt.sfml_operator_le_BfEBfE(to_unsafe, right, out result)
      return result
    end
    # Overload of &gt;= operator to compare two IP addresses
    #
    # * *left* - Left operand (a IP address)
    # * *right* - Right operand (a IP address)
    #
    # *Returns:* True if *left* is greater or equal than *right*
    def >=(right : IpAddress) : Bool
      SFMLExt.sfml_operator_ge_BfEBfE(to_unsafe, right, out result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@address).as(Void*)
    end
    # :nodoc:
    def initialize(copy : IpAddress)
      @address = uninitialized UInt32
      @valid = uninitialized Bool
      SFMLExt.sfml_ipaddress_initialize_BfE(to_unsafe, copy)
    end
    def dup() : IpAddress
      return IpAddress.new(self)
    end
  end
  # A HTTP client
  #
  # `SF::Http` is a very simple HTTP client that allows you
  # to communicate with a web server. You can retrieve
  # web pages, send data to an interactive resource,
  # download a remote file, etc. The HTTPS protocol is
  # not supported.
  #
  # The HTTP client is split into 3 classes:
  #
  # * `SF::Http::Request`
  # * `SF::Http::Response`
  # * `SF::Http`
  #
  # `SF::Http::Request` builds the request that will be
  # sent to the server. A request is made of:
  #
  # * a method (what you want to do)
  # * a target URI (usually the name of the web page or file)
  # * one or more header fields (options that you can pass to the server)
  # * an optional body (for POST requests)
  #
  # `SF::Http::Response` parse the response from the web server
  # and provides getters to read them. The response contains:
  #
  # * a status code
  # * header fields (that may be answers to the ones that you requested)
  # * a body, which contains the contents of the requested resource
  #
  # `SF::Http` provides a simple function, SendRequest, to send a
  # `SF::Http::Request` and return the corresponding `SF::Http::Response`
  # from the server.
  #
  # Usage example:
  # ```crystal
  # # Create a new HTTP client
  # http = SF::Http.new("http://www.sfml-dev.org")
  #
  # # Prepare a request to get the 'features.php' page
  # request = SF::Http::Request.new("features.php")
  #
  # # Send the request
  # response = http.send_request request
  #
  # # Check the status code and display the result
  # status = response.status
  # if status.ok?
  #   puts response.body
  # else
  #   puts "Error #{response.status}"
  # end
  # ```
  class Http
    @this : Void*
    def finalize()
      SFMLExt.sfml_http_finalize(to_unsafe)
      SFMLExt.sfml_http_free(@this)
    end
    # Define a HTTP request
    class Request
      @this : Void*
      def finalize()
        SFMLExt.sfml_http_request_finalize(to_unsafe)
        SFMLExt.sfml_http_request_free(@this)
      end
      # Enumerate the available HTTP methods for a request
      enum Method
        # Request in get mode, standard method to retrieve a page
        Get
        # Request in post mode, usually to send data to a page
        Post
        # Request a page's header only
        Head
        # Request in put mode, useful for a REST API
        Put
        # Request in delete mode, useful for a REST API
        Delete
      end
      Util.extract Http::Request::Method
      # Default constructor
      #
      # This constructor creates a GET request, with the root
      # URI ("/") and an empty body.
      #
      # * *uri* - Target URI
      # * *method* - Method to use for the request
      # * *body* - Content of the request's body
      def initialize(uri : String = "/", method : Http::Request::Method = Get, body : String = "")
        SFMLExt.sfml_http_request_allocate(out @this)
        SFMLExt.sfml_http_request_initialize_zkC1ctzkC(to_unsafe, uri.bytesize, uri, method, body.bytesize, body)
      end
      # Set the value of a field
      #
      # The field is created if it doesn't exist. The name of
      # the field is case-insensitive.
      # By default, a request doesn't contain any field (but the
      # mandatory fields are added later by the HTTP client when
      # sending the request).
      #
      # * *field* - Name of the field to set
      # * *value* - Value of the field
      def set_field(field : String, value : String)
        SFMLExt.sfml_http_request_setfield_zkCzkC(to_unsafe, field.bytesize, field, value.bytesize, value)
      end
      # Set the request method
      #
      # See the Method enumeration for a complete list of all
      # the availale methods.
      # The method is Http::Request::Get by default.
      #
      # * *method* - Method to use for the request
      def method=(method : Http::Request::Method)
        SFMLExt.sfml_http_request_setmethod_1ct(to_unsafe, method)
      end
      # Set the requested URI
      #
      # The URI is the resource (usually a web page or a file)
      # that you want to get or post.
      # The URI is "/" (the root page) by default.
      #
      # * *uri* - URI to request, relative to the host
      def uri=(uri : String)
        SFMLExt.sfml_http_request_seturi_zkC(to_unsafe, uri.bytesize, uri)
      end
      # Set the HTTP version for the request
      #
      # The HTTP version is 1.0 by default.
      #
      # * *major* - Major HTTP version number
      # * *minor* - Minor HTTP version number
      def set_http_version(major : Int, minor : Int)
        SFMLExt.sfml_http_request_sethttpversion_emSemS(to_unsafe, LibC::UInt.new(major), LibC::UInt.new(minor))
      end
      # Set the body of the request
      #
      # The body of a request is optional and only makes sense
      # for POST requests. It is ignored for all other methods.
      # The body is empty by default.
      #
      # * *body* - Content of the body
      def body=(body : String)
        SFMLExt.sfml_http_request_setbody_zkC(to_unsafe, body.bytesize, body)
      end
      # :nodoc:
      def to_unsafe()
        @this
      end
      # :nodoc:
      def inspect(io)
        to_s(io)
      end
      # :nodoc:
      def initialize(copy : Http::Request)
        SFMLExt.sfml_http_request_allocate(out @this)
        SFMLExt.sfml_http_request_initialize_Jat(to_unsafe, copy)
      end
      def dup() : Request
        return Request.new(self)
      end
    end
    # Define a HTTP response
    class Response
      @this : Void*
      def finalize()
        SFMLExt.sfml_http_response_finalize(to_unsafe)
        SFMLExt.sfml_http_response_free(@this)
      end
      # Enumerate all the valid status codes for a response
      enum Status
        # Most common code returned when operation was successful
        Ok = 200
        # The resource has successfully been created
        Created = 201
        # The request has been accepted, but will be processed later by the server
        Accepted = 202
        # The server didn't send any data in return
        NoContent = 204
        # The server informs the client that it should clear the view (form) that caused the request to be sent
        ResetContent = 205
        # The server has sent a part of the resource, as a response to a partial GET request
        PartialContent = 206
        # The requested page can be accessed from several locations
        MultipleChoices = 300
        # The requested page has permanently moved to a new location
        MovedPermanently = 301
        # The requested page has temporarily moved to a new location
        MovedTemporarily = 302
        # For conditional requests, means the requested page hasn't changed and doesn't need to be refreshed
        NotModified = 304
        # The server couldn't understand the request (syntax error)
        BadRequest = 400
        # The requested page needs an authentication to be accessed
        Unauthorized = 401
        # The requested page cannot be accessed at all, even with authentication
        Forbidden = 403
        # The requested page doesn't exist
        NotFound = 404
        # The server can't satisfy the partial GET request (with a "Range" header field)
        RangeNotSatisfiable = 407
        # The server encountered an unexpected error
        InternalServerError = 500
        # The server doesn't implement a requested feature
        NotImplemented = 501
        # The gateway server has received an error from the source server
        BadGateway = 502
        # The server is temporarily unavailable (overloaded, in maintenance, ...)
        ServiceNotAvailable = 503
        # The gateway server couldn't receive a response from the source server
        GatewayTimeout = 504
        # The server doesn't support the requested HTTP version
        VersionNotSupported = 505
        # Response is not a valid HTTP one
        InvalidResponse = 1000
        # Connection with server failed
        ConnectionFailed = 1001
      end
      Util.extract Http::Response::Status
      # Default constructor
      #
      # Constructs an empty response.
      def initialize()
        SFMLExt.sfml_http_response_allocate(out @this)
        SFMLExt.sfml_http_response_initialize(to_unsafe)
      end
      # Get the value of a field
      #
      # If the field *field* is not found in the response header,
      # the empty string is returned. This function uses
      # case-insensitive comparisons.
      #
      # * *field* - Name of the field to get
      #
      # *Returns:* Value of the field, or empty string if not found
      def get_field(field : String) : String
        SFMLExt.sfml_http_response_getfield_zkC(to_unsafe, field.bytesize, field, out result)
        return String.new(result)
      end
      # Get the response status code
      #
      # The status code should be the first thing to be checked
      # after receiving a response, it defines whether it is a
      # success, a failure or anything else (see the Status
      # enumeration).
      #
      # *Returns:* Status code of the response
      def status() : Http::Response::Status
        SFMLExt.sfml_http_response_getstatus(to_unsafe, out result)
        return Http::Response::Status.new(result)
      end
      # Get the major HTTP version number of the response
      #
      # *Returns:* Major HTTP version number
      #
      # *See also:* `minor_http_version`
      def major_http_version() : Int32
        SFMLExt.sfml_http_response_getmajorhttpversion(to_unsafe, out result)
        return result.to_i
      end
      # Get the minor HTTP version number of the response
      #
      # *Returns:* Minor HTTP version number
      #
      # *See also:* `major_http_version`
      def minor_http_version() : Int32
        SFMLExt.sfml_http_response_getminorhttpversion(to_unsafe, out result)
        return result.to_i
      end
      # Get the body of the response
      #
      # The body of a response may contain:
      #
      # * the requested page (for GET requests)
      # * a response from the server (for POST requests)
      # * nothing (for HEAD requests)
      # * an error message (in case of an error)
      #
      # *Returns:* The response body
      def body() : String
        SFMLExt.sfml_http_response_getbody(to_unsafe, out result)
        return String.new(result)
      end
      # :nodoc:
      def to_unsafe()
        @this
      end
      # :nodoc:
      def inspect(io)
        to_s(io)
      end
      # :nodoc:
      def initialize(copy : Http::Response)
        SFMLExt.sfml_http_response_allocate(out @this)
        SFMLExt.sfml_http_response_initialize_N50(to_unsafe, copy)
      end
      def dup() : Response
        return Response.new(self)
      end
    end
    # Default constructor
    def initialize()
      SFMLExt.sfml_http_allocate(out @this)
      SFMLExt.sfml_http_initialize(to_unsafe)
    end
    # Construct the HTTP client with the target host
    #
    # This is equivalent to calling host=(host, port).
    # The port has a default value of 0, which means that the
    # HTTP client will use the right port according to the
    # protocol used (80 for HTTP). You should leave it like
    # this unless you really need a port other than the
    # standard one, or use an unknown protocol.
    #
    # * *host* - Web server to connect to
    # * *port* - Port to use for connection
    def initialize(host : String, port : Int = 0)
      SFMLExt.sfml_http_allocate(out @this)
      SFMLExt.sfml_http_initialize_zkCbxi(to_unsafe, host.bytesize, host, LibC::UShort.new(port))
    end
    # Set the target host
    #
    # This function just stores the host address and port, it
    # doesn't actually connect to it until you send a request.
    # The port has a default value of 0, which means that the
    # HTTP client will use the right port according to the
    # protocol used (80 for HTTP). You should leave it like
    # this unless you really need a port other than the
    # standard one, or use an unknown protocol.
    #
    # * *host* - Web server to connect to
    # * *port* - Port to use for connection
    def set_host(host : String, port : Int = 0)
      SFMLExt.sfml_http_sethost_zkCbxi(to_unsafe, host.bytesize, host, LibC::UShort.new(port))
    end
    # Send a HTTP request and return the server's response.
    #
    # You must have a valid host before sending a request (see host=).
    # Any missing mandatory header field in the request will be added
    # with an appropriate value.
    #
    # WARNING: This function waits for the server's response and may
    # not return instantly; use a thread if you don't want to block your
    # application, or use a timeout to limit the time to wait. A value
    # of Time::Zero means that the client will use the system default timeout
    # (which is usually pretty long).
    #
    # * *request* - Request to send
    # * *timeout* - Maximum time to wait
    #
    # *Returns:* Server's response
    def send_request(request : Http::Request, timeout : Time = Time::Zero) : Http::Response
      result = Http::Response.new
      SFMLExt.sfml_http_sendrequest_Jatf4T(to_unsafe, request, timeout, result)
      return result
    end
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Utility class to build blocks of data to transfer
  # over the network
  #
  # Packets provide a safe and easy way to serialize data,
  # in order to send it over the network using sockets
  # (`SF::TcpSocket`, `SF::UdpSocket`).
  #
  # Packets solve 2 fundamental problems that arise when
  # transferring data over the network:
  #
  # * data is interpreted correctly according to the endianness
  # * the bounds of the packet are preserved (one send == one receive)
  #
  # The `SF::Packet` class provides both input and output, using `read`
  # and `write` methods.
  #
  # It is recommended to use only fixed-size types (like `Int32`, etc.),
  # to avoid possible differences between the sender and the receiver.
  #
  # Usage example:
  # ```crystal
  # x = 24u32
  # s = "hello"
  # d = 5.89
  #
  # # Group the variables to send into a packet
  # packet = SF::Packet.new
  # packet.write x
  # packet.write s
  # packet.write d
  #
  # # Send it over the network (socket is a valid SF::TcpSocket)
  # socket.send packet
  #
  # # -----------------------------------------------------------------
  #
  # # Receive the packet at the other end
  # packet = SF::Packet.new
  # socket.receive(packet)
  #
  # # Extract the variables contained in the packet
  # x = packet.read UInt32
  # s = packet.read String
  # d = packet.read Float64
  # if packet.valid?
  #   # Data extracted successfully...
  # end
  # ```
  #
  # Packets have overloads of `read` and `write` methods for standard types:
  #
  # * Bool
  # * Fixed-size integer types (`Int8/16/32/64`, `UInt8/16/32/64`)
  # * Floating point numbers (`Float32/64`)
  # * `String`
  #
  # Like standard streams, it is also possible to define your own overloads
  # of these methods in order to handle your custom types.
  #
  # ```crystal
  # struct MyStruct
  #   number : Float32
  #   integer : Int8
  #   str : String
  # end
  #
  # class SF::Packet
  #   def write(m : MyStruct)
  #     write m.number
  #     write m.integer
  #     write m.str
  #   end
  #
  #   def read(type : MyStruct.class) : MyStruct
  #     MyStruct.new(packet.read(Float32), packet.read(Int8), packet.read(String))
  #   end
  # end
  # ```
  #
  # *See also:* `SF::TcpSocket`, `SF::UdpSocket`
  class Packet
    @this : Void*
    # Default constructor
    #
    # Creates an empty packet.
    def initialize()
      SFMLExt.sfml_packet_allocate(out @this)
      SFMLExt.sfml_packet_initialize(to_unsafe)
    end
    # Virtual destructor
    def finalize()
      SFMLExt.sfml_packet_finalize(to_unsafe)
      SFMLExt.sfml_packet_free(@this)
    end
    # Append data to the end of the packet
    #
    # * *data* - Pointer to the sequence of bytes to append
    # * *size_in_bytes* - Number of bytes to append
    #
    # *See also:* `clear`
    def append(data : Slice)
      SFMLExt.sfml_packet_append_5h8vgv(to_unsafe, data, data.bytesize)
    end
    # Clear the packet
    #
    # After calling Clear, the packet is empty.
    #
    # *See also:* `append`
    def clear()
      SFMLExt.sfml_packet_clear(to_unsafe)
    end
    # Get a pointer to the data contained in the packet
    #
    # WARNING: The returned pointer may become invalid after
    # you append data to the packet, therefore it should never
    # be stored.
    # The return pointer is NULL if the packet is empty.
    #
    # *Returns:* Pointer to the data
    #
    # *See also:* `data_size`
    def data() : Void*
      SFMLExt.sfml_packet_getdata(to_unsafe, out result)
      return result
    end
    # Get the size of the data contained in the packet
    #
    # This function returns the number of bytes pointed to by
    # what data returns.
    #
    # *Returns:* Data size, in bytes
    #
    # *See also:* `data`
    def data_size() : Int32
      SFMLExt.sfml_packet_getdatasize(to_unsafe, out result)
      return result.to_i
    end
    # Tell if the reading position has reached the
    # end of the packet
    #
    # This function is useful to know if there is some data
    # left to be read, without actually reading it.
    #
    # *Returns:* True if all data was read, false otherwise
    #
    # *See also:* `operator` `bool`
    def end_of_packet() : Bool
      SFMLExt.sfml_packet_endofpacket(to_unsafe, out result)
      return result
    end
    # Test the validity of the packet, for reading
    #
    # This operator allows to test the packet as a boolean
    # variable, to check if a reading operation was successful.
    #
    # A packet will be in an invalid state if it has no more
    # data to read.
    #
    # This behavior is the same as standard C++ streams.
    #
    # Usage example:
    # ```crystal
    # x = packet.read(Float32)
    # if packet.valid?
    #   # ok, x was extracted successfully
    # end
    # ```
    #
    # *Returns:* True if last data extraction from packet was successful
    #
    # *See also:* `end_of_packet`
    def valid?() : Bool
      SFMLExt.sfml_packet_operator_bool(to_unsafe, out result)
      return result
    end
    # Read data from the packet. The expected type corresponds to
    # what was actually sent.
    def read(type : Bool.class) : Bool
      SFMLExt.sfml_packet_operator_shr_gRY(to_unsafe, out data)
      return data
    end
    # :ditto:
    def read(type : Int8.class) : Int8
      SFMLExt.sfml_packet_operator_shr_0y9(to_unsafe, out data)
      return data
    end
    # :ditto:
    def read(type : UInt8.class) : UInt8
      SFMLExt.sfml_packet_operator_shr_8hc(to_unsafe, out data)
      return data
    end
    # :ditto:
    def read(type : Int16.class) : Int16
      SFMLExt.sfml_packet_operator_shr_4k3(to_unsafe, out data)
      return data
    end
    # :ditto:
    def read(type : UInt16.class) : UInt16
      SFMLExt.sfml_packet_operator_shr_Xag(to_unsafe, out data)
      return data
    end
    # :ditto:
    def read(type : Int32.class) : Int32
      SFMLExt.sfml_packet_operator_shr_NiZ(to_unsafe, out data)
      return data
    end
    # :ditto:
    def read(type : UInt32.class) : UInt32
      SFMLExt.sfml_packet_operator_shr_qTz(to_unsafe, out data)
      return data
    end
    # :ditto:
    def read(type : Int64.class) : Int64
      SFMLExt.sfml_packet_operator_shr_BuW(to_unsafe, out data)
      return data
    end
    # :ditto:
    def read(type : UInt64.class) : UInt64
      SFMLExt.sfml_packet_operator_shr_7H7(to_unsafe, out data)
      return data
    end
    # :ditto:
    def read(type : Float32.class) : Float32
      SFMLExt.sfml_packet_operator_shr_ATF(to_unsafe, out data)
      return data
    end
    # :ditto:
    def read(type : Float64.class) : Float64
      SFMLExt.sfml_packet_operator_shr_nIp(to_unsafe, out data)
      return data
    end
    # :ditto:
    def read(type : String.class) : String
      SFMLExt.sfml_packet_operator_shr_GHF(to_unsafe, out data)
      return String.new(data)
    end
    # Write data into the packet
    def write(data : Bool)
      SFMLExt.sfml_packet_operator_shl_GZq(to_unsafe, data)
      self
    end
    # :ditto:
    def write(data : Int8)
      SFMLExt.sfml_packet_operator_shl_k6g(to_unsafe, data)
      self
    end
    # :ditto:
    def write(data : UInt8)
      SFMLExt.sfml_packet_operator_shl_9yU(to_unsafe, data)
      self
    end
    # :ditto:
    def write(data : Int16)
      SFMLExt.sfml_packet_operator_shl_yAA(to_unsafe, data)
      self
    end
    # :ditto:
    def write(data : UInt16)
      SFMLExt.sfml_packet_operator_shl_BtU(to_unsafe, data)
      self
    end
    # :ditto:
    def write(data : Int32)
      SFMLExt.sfml_packet_operator_shl_qe2(to_unsafe, data)
      self
    end
    # :ditto:
    def write(data : UInt32)
      SFMLExt.sfml_packet_operator_shl_saL(to_unsafe, data)
      self
    end
    # :ditto:
    def write(data : Int64)
      SFMLExt.sfml_packet_operator_shl_G4x(to_unsafe, data)
      self
    end
    # :ditto:
    def write(data : UInt64)
      SFMLExt.sfml_packet_operator_shl_Jvt(to_unsafe, data)
      self
    end
    # :ditto:
    def write(data : Float32)
      SFMLExt.sfml_packet_operator_shl_Bw9(to_unsafe, data)
      self
    end
    # :ditto:
    def write(data : Float64)
      SFMLExt.sfml_packet_operator_shl_mYt(to_unsafe, data)
      self
    end
    # :ditto:
    def write(data : String)
      SFMLExt.sfml_packet_operator_shl_zkC(to_unsafe, data.bytesize, data)
      self
    end
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def initialize(copy : Packet)
      SFMLExt.sfml_packet_allocate(out @this)
      SFMLExt.sfml_packet_initialize_54U(to_unsafe, copy)
    end
    def dup() : Packet
      return Packet.new(self)
    end
  end
  # Multiplexer that allows to read from multiple sockets
  #
  # Socket selectors provide a way to wait until some data is
  # available on a set of sockets, instead of just one. This
  # is convenient when you have multiple sockets that may
  # possibly receive data, but you don't know which one will
  # be ready first. In particular, it avoids to use a thread
  # for each socket; with selectors, a single thread can handle
  # all the sockets.
  #
  # All types of sockets can be used in a selector:
  #
  # * `SF::TcpListener`
  # * `SF::TcpSocket`
  # * `SF::UdpSocket`
  #
  # A selector doesn't store its own copies of the sockets
  # (socket classes are not copyable anyway), it simply keeps
  # a reference to the original sockets that you pass to the
  # "add" function. Therefore, you can't use the selector as a
  # socket container, you must store them outside and make sure
  # that they are alive as long as they are used in the selector.
  #
  # Using a selector is simple:
  #
  # * populate the selector with all the sockets that you want to observe
  # * make it wait until there is data available on any of the sockets
  # * test each socket to find out which ones are ready
  #
  # Usage example:
  # ```crystal
  # # Create a socket to listen to new connections
  # listener = SF::TcpListener.new
  # listener.listen(55001)
  #
  # # Create an array to store the future clients
  # clients = [] of SF::TcpSocket
  #
  # # Create a selector
  # selector = SF::SocketSelector.new
  #
  # # Add the listener to the selector
  # selector.add listener
  #
  # # Endless loop that waits for new connections
  # while running
  #   # Make the selector wait for data on any socket
  #   if selector.wait
  #     # Test the listener
  #     if selector.ready?(listener)
  #       # The listener is ready: there is a pending connection
  #       client = SF::TcpSocket.new
  #       if listener.accept(client) == SF::Socket::Done
  #         # Add the new client to the clients list
  #         clients << client
  #
  #         # Add the new client to the selector so that we will
  #         # be notified when he sends something
  #         selector.add client
  #       end
  #     else
  #       # The listener socket is not ready, test all other sockets (the clients)
  #       clients.each do |client|
  #         if selector.ready?(client)
  #           # The client has sent some data, we can receive it
  #           packet = SF::Packet.new
  #           if client.receive(packet) == SF::Socket::Done
  #             [...]
  #           end
  #         end
  #       end
  #     end
  #   end
  # end
  # ```
  #
  # *See also:* `SF::Socket`
  class SocketSelector
    @this : Void*
    # Default constructor
    def initialize()
      SFMLExt.sfml_socketselector_allocate(out @this)
      SFMLExt.sfml_socketselector_initialize(to_unsafe)
    end
    # Destructor
    def finalize()
      SFMLExt.sfml_socketselector_finalize(to_unsafe)
      SFMLExt.sfml_socketselector_free(@this)
    end
    # Add a new socket to the selector
    #
    # This function keeps a weak reference to the socket,
    # so you have to make sure that the socket is not destroyed
    # while it is stored in the selector.
    # This function does nothing if the socket is not valid.
    #
    # * *socket* - Reference to the socket to add
    #
    # *See also:* `remove`, `clear`
    def add(socket : Socket)
      SFMLExt.sfml_socketselector_add_JTp(to_unsafe, socket)
    end
    # Remove a socket from the selector
    #
    # This function doesn't destroy the socket, it simply
    # removes the reference that the selector has to it.
    #
    # * *socket* - Reference to the socket to remove
    #
    # *See also:* `add`, `clear`
    def remove(socket : Socket)
      SFMLExt.sfml_socketselector_remove_JTp(to_unsafe, socket)
    end
    # Remove all the sockets stored in the selector
    #
    # This function doesn't destroy any instance, it simply
    # removes all the references that the selector has to
    # external sockets.
    #
    # *See also:* `add`, `remove`
    def clear()
      SFMLExt.sfml_socketselector_clear(to_unsafe)
    end
    # Wait until one or more sockets are ready to receive
    #
    # This function returns as soon as at least one socket has
    # some data available to be received. To know which sockets are
    # ready, use the ready? function.
    # If you use a timeout and no socket is ready before the timeout
    # is over, the function returns false.
    #
    # * *timeout* - Maximum time to wait, (use Time::Zero for infinity)
    #
    # *Returns:* True if there are sockets ready, false otherwise
    #
    # *See also:* `ready?`
    def wait(timeout : Time = Time::Zero) : Bool
      SFMLExt.sfml_socketselector_wait_f4T(to_unsafe, timeout, out result)
      return result
    end
    # Test a socket to know if it is ready to receive data
    #
    # This function must be used after a call to Wait, to know
    # which sockets are ready to receive data. If a socket is
    # ready, a call to receive will never block because we know
    # that there is data available to read.
    # Note that if this function returns true for a TcpListener,
    # this means that it is ready to accept a new connection.
    #
    # * *socket* - Socket to test
    #
    # *Returns:* True if the socket is ready to read, false otherwise
    #
    # *See also:* `ready?`
    def ready?(socket : Socket) : Bool
      SFMLExt.sfml_socketselector_isready_JTp(to_unsafe, socket, out result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def initialize(copy : SocketSelector)
      SFMLExt.sfml_socketselector_allocate(out @this)
      SFMLExt.sfml_socketselector_initialize_fWq(to_unsafe, copy)
    end
    def dup() : SocketSelector
      return SocketSelector.new(self)
    end
  end
  # Socket that listens to new TCP connections
  #
  # A listener socket is a special type of socket that listens to
  # a given port and waits for connections on that port.
  # This is all it can do.
  #
  # When a new connection is received, you must call accept and
  # the listener returns a new instance of `SF::TcpSocket` that
  # is properly initialized and can be used to communicate with
  # the new client.
  #
  # Listener sockets are specific to the TCP protocol,
  # UDP sockets are connectionless and can therefore communicate
  # directly. As a consequence, a listener socket will always
  # return the new connections as `SF::TcpSocket` instances.
  #
  # A listener is automatically closed on destruction, like all
  # other types of socket. However if you want to stop listening
  # before the socket is destroyed, you can call its `close()`
  # function.
  #
  # Usage example:
  # ```crystal
  # # Create a listener socket and make it wait for new
  # # connections on port 55001
  # listener = SF::TcpListener.new
  # listener.listen(55001)
  #
  # # Endless loop that waits for new connections
  # while running
  #   client = SF::TcpSocket.new
  #   if listener.accept(client) == SF::Socket::Done
  #     # A new client just connected!
  #     puts "New connection received from #{client.remote_address}"
  #     do_something_with client
  #   end
  # end
  # ```
  #
  # *See also:* `SF::TcpSocket`, `SF::Socket`
  class TcpListener < Socket
    @this : Void*
    def finalize()
      SFMLExt.sfml_tcplistener_finalize(to_unsafe)
      SFMLExt.sfml_tcplistener_free(@this)
    end
    # Default constructor
    def initialize()
      SFMLExt.sfml_tcplistener_allocate(out @this)
      SFMLExt.sfml_tcplistener_initialize(to_unsafe)
    end
    # Get the port to which the socket is bound locally
    #
    # If the socket is not listening to a port, this function
    # returns 0.
    #
    # *Returns:* Port to which the socket is bound
    #
    # *See also:* `listen`
    def local_port() : UInt16
      SFMLExt.sfml_tcplistener_getlocalport(to_unsafe, out result)
      return result
    end
    # Start listening for incoming connection attempts
    #
    # This function makes the socket start listening on the
    # specified port, waiting for incoming connection attempts.
    #
    # If the socket is already listening on a port when this
    # function is called, it will stop listening on the old
    # port before starting to listen on the new port.
    #
    # * *port* - Port to listen on for incoming connection attempts
    # * *address* - Address of the interface to listen on
    #
    # *Returns:* Status code
    #
    # *See also:* `accept`, `close`
    def listen(port : Int, address : IpAddress = IpAddress::Any) : Socket::Status
      SFMLExt.sfml_tcplistener_listen_bxiBfE(to_unsafe, LibC::UShort.new(port), address, out result)
      return Socket::Status.new(result)
    end
    # Stop listening and close the socket
    #
    # This function gracefully stops the listener. If the
    # socket is not listening, this function has no effect.
    #
    # *See also:* `listen`
    def close()
      SFMLExt.sfml_tcplistener_close(to_unsafe)
    end
    # Accept a new connection
    #
    # If the socket is in blocking mode, this function will
    # not return until a connection is actually received.
    #
    # * *socket* - Socket that will hold the new connection
    #
    # *Returns:* Status code
    #
    # *See also:* `listen`
    def accept(socket : TcpSocket) : Socket::Status
      SFMLExt.sfml_tcplistener_accept_WsF(to_unsafe, socket, out result)
      return Socket::Status.new(result)
    end
    # :nodoc:
    def blocking=(blocking : Bool)
      SFMLExt.sfml_tcplistener_setblocking_GZq(to_unsafe, blocking)
    end
    # :nodoc:
    def blocking?() : Bool
      SFMLExt.sfml_tcplistener_isblocking(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Specialized socket using the UDP protocol
  #
  # A UDP socket is a connectionless socket. Instead of
  # connecting once to a remote host, like TCP sockets,
  # it can send to and receive from any host at any time.
  #
  # It is a datagram protocol: bounded blocks of data (datagrams)
  # are transfered over the network rather than a continuous
  # stream of data (TCP). Therefore, one call to send will always
  # match one call to receive (if the datagram is not lost),
  # with the same data that was sent.
  #
  # The UDP protocol is lightweight but unreliable. Unreliable
  # means that datagrams may be duplicated, be lost or
  # arrive reordered. However, if a datagram arrives, its
  # data is guaranteed to be valid.
  #
  # UDP is generally used for real-time communication
  # (audio or video streaming, real-time games, etc.) where
  # speed is crucial and lost data doesn't matter much.
  #
  # Sending and receiving data can use either the low-level
  # or the high-level functions. The low-level functions
  # process a raw sequence of bytes, whereas the high-level
  # interface uses packets (see `SF::Packet`), which are easier
  # to use and provide more safety regarding the data that is
  # exchanged. You can look at the `SF::Packet` class to get
  # more details about how they work.
  #
  # It is important to note that UdpSocket is unable to send
  # datagrams bigger than MaxDatagramSize. In this case, it
  # returns an error and doesn't send anything. This applies
  # to both raw data and packets. Indeed, even packets are
  # unable to split and recompose data, due to the unreliability
  # of the protocol (dropped, mixed or duplicated datagrams may
  # lead to a big mess when trying to recompose a packet).
  #
  # If the socket is bound to a port, it is automatically
  # unbound from it when the socket is destroyed. However,
  # you can unbind the socket explicitly with the Unbind
  # function if necessary, to stop receiving messages or
  # make the port available for other sockets.
  #
  # Usage example:
  # ```crystal
  # # ----- The client -----
  #
  # # Create a socket and bind it to the port 55001
  # socket = SF::UdpSocket.new
  # socket.bind(55001)
  #
  # # Send a message to 192.168.1.50 on port 55002
  # message = "Hi, I am #{SF::IpAddress.local_address}"
  # socket.send(message.to_slice, "192.168.1.50", 55002)
  #
  # # Receive an answer (most likely from 192.168.1.50, but could be anyone else)
  # buffer = Slice(UInt8).new(1024)
  # status, received, sender, port = socket.receive(buffer)
  # puts "#{sender} said: #{buffer}"
  #
  # # ----- The server -----
  #
  # # Create a socket and bind it to the port 55002
  # socket = SF::UdpSocket.new
  # socket.bind(55002)
  #
  # # Receive a message from anyone
  # buffer = Slice(UInt8).new(1024)
  # status, received, sender, port = socket.receive(buffer)
  # puts "#{sender} said: #{buffer}"
  #
  # # Send an answer
  # message = "Welcome #{sender}"
  # socket.send(message.to_slice, sender, port)
  # ```
  #
  # *See also:* `SF::Socket`, `SF::TcpSocket`, `SF::Packet`
  class UdpSocket < Socket
    @this : Void*
    def finalize()
      SFMLExt.sfml_udpsocket_finalize(to_unsafe)
      SFMLExt.sfml_udpsocket_free(@this)
    end
    # The maximum number of bytes that can be sent in a single UDP datagram
    MaxDatagramSize = 65507
    # Default constructor
    def initialize()
      SFMLExt.sfml_udpsocket_allocate(out @this)
      SFMLExt.sfml_udpsocket_initialize(to_unsafe)
    end
    # Get the port to which the socket is bound locally
    #
    # If the socket is not bound to a port, this function
    # returns 0.
    #
    # *Returns:* Port to which the socket is bound
    #
    # *See also:* `bind`
    def local_port() : UInt16
      SFMLExt.sfml_udpsocket_getlocalport(to_unsafe, out result)
      return result
    end
    # Bind the socket to a specific port
    #
    # Binding the socket to a port is necessary for being
    # able to receive data on that port.
    # You can use the special value Socket::AnyPort to tell the
    # system to automatically pick an available port, and then
    # call local_port to retrieve the chosen port.
    #
    # Since the socket can only be bound to a single port at
    # any given moment, if it is already bound when this
    # function is called, it will be unbound from the previous
    # port before being bound to the new one.
    #
    # * *port* - Port to bind the socket to
    # * *address* - Address of the interface to bind to
    #
    # *Returns:* Status code
    #
    # *See also:* `unbind`, `local_port`
    def bind(port : Int, address : IpAddress = IpAddress::Any) : Socket::Status
      SFMLExt.sfml_udpsocket_bind_bxiBfE(to_unsafe, LibC::UShort.new(port), address, out result)
      return Socket::Status.new(result)
    end
    # Unbind the socket from the local port to which it is bound
    #
    # The port that the socket was previously bound to is immediately
    # made available to the operating system after this function is called.
    # This means that a subsequent call to `bind()` will be able to re-bind
    # the port if no other process has done so in the mean time.
    # If the socket is not bound to a port, this function has no effect.
    #
    # *See also:* `bind`
    def unbind()
      SFMLExt.sfml_udpsocket_unbind(to_unsafe)
    end
    # Send raw data to a remote peer
    #
    # Make sure that *data* size is not greater than
    # `UdpSocket::MaxDatagramSize`, otherwise this function will
    # fail and no data will be sent.
    #
    # * *data* - Slice containing the sequence of bytes to send
    # * *remote_address* - Address of the receiver
    # * *remote_port* - Port of the receiver to send the data to
    #
    # *Returns:* Status code
    #
    # *See also:* `receive`
    def send(data : Slice, remote_address : IpAddress, remote_port : Int) : Socket::Status
      SFMLExt.sfml_udpsocket_send_5h8vgvBfEbxi(to_unsafe, data, data.bytesize, remote_address, LibC::UShort.new(remote_port), out result)
      return Socket::Status.new(result)
    end
    # Receive raw data from a remote peer
    #
    # In blocking mode, this function will wait until some
    # bytes are actually received.
    # Be careful to use a buffer which is large enough for
    # the data that you intend to receive, if it is too small
    # then an error will be returned and *all* the data will
    # be lost.
    #
    # * *data* - The slice to fill with the received bytes
    #
    # *Returns:*
    #
    # * Status code
    # * The actual number of bytes received
    # * Address of the peer that sent the data
    # * Port of the peer that sent the data
    #
    # *See also:* `send`
    def receive(data : Slice) : {Socket::Status, Int32, IpAddress, UInt16}
      remote_address = IpAddress.new
      SFMLExt.sfml_udpsocket_receive_xALvgvi499ylYII(to_unsafe, data, data.bytesize, out received, remote_address, out remote_port, out result)
      return Socket::Status.new(result), received.to_i, remote_address, remote_port
    end
    # Send a formatted packet of data to a remote peer
    #
    # Make sure that the packet size is not greater than
    # UdpSocket::MaxDatagramSize, otherwise this function will
    # fail and no data will be sent.
    #
    # * *packet* - Packet to send
    # * *remote_address* - Address of the receiver
    # * *remote_port* - Port of the receiver to send the data to
    #
    # *Returns:* Status code
    #
    # *See also:* `receive`
    def send(packet : Packet, remote_address : IpAddress, remote_port : Int) : Socket::Status
      SFMLExt.sfml_udpsocket_send_jyFBfEbxi(to_unsafe, packet, remote_address, LibC::UShort.new(remote_port), out result)
      return Socket::Status.new(result)
    end
    # Receive a formatted packet of data from a remote peer
    #
    # In blocking mode, this function will wait until the whole packet
    # has been received.
    #
    # * *packet* - Packet to fill with the received data
    #
    # *Returns:*
    #
    # * Status code
    # * Address of the peer that sent the data
    # * Port of the peer that sent the data
    #
    # *See also:* `send`
    def receive(packet : Packet) : {Socket::Status, IpAddress, UInt16}
      remote_address = IpAddress.new
      SFMLExt.sfml_udpsocket_receive_jyF9ylYII(to_unsafe, packet, remote_address, out remote_port, out result)
      return Socket::Status.new(result), remote_address, remote_port
    end
    # :nodoc:
    def blocking=(blocking : Bool)
      SFMLExt.sfml_udpsocket_setblocking_GZq(to_unsafe, blocking)
    end
    # :nodoc:
    def blocking?() : Bool
      SFMLExt.sfml_udpsocket_isblocking(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  SFMLExt.sfml_network_version(out major, out minor, out patch)
  if SFML_VERSION != (ver = "#{major}.#{minor}.#{patch}")
    STDERR.puts "Warning: CrSFML was built for SFML #{SFML_VERSION}, found SFML #{ver}"
  end
end
