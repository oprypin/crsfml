require "./network_lib"
require "./common_obj"

module SF
  extend self

  # Encapsulate an IPv4 network address
  alias IpAddress = CSFML::IpAddress

  struct CSFML::IpAddress
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
    def to_integer()
      CSFML.ip_address_to_integer(self)
    end
    
    # Get the computer's local address
    # 
    # The local address is the address of the computer from the
    # LAN point of view, i.e. something like 192.168.1.56. It is
    # meaningful only for communications over the local network.
    # Unlike IpAddress_getPublicAddress, this function is fast
    # and may be used safely anywhere.
    # 
    # *Returns*: Local IP address of the computer
    def self.local_address
      CSFML.ip_address_get_local_address()
    end
    
    # Deprecated alias to `local_address`
    def self.get_local_address()
      CSFML.ip_address_get_local_address()
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
    # to be possibly stuck waiting in case there is a problem; use
    # 0 to deactivate this limit.
    # 
    # *Arguments*:
    # 
    # * `timeout`: Maximum time to wait
    # 
    # *Returns*: Public IP address of the computer
    def self.get_public_address(timeout: Time)
      CSFML.ip_address_get_public_address(timeout)
    end
    
  end

  class FtpDirectoryResponse
    include Wrapper(CSFML::FtpDirectoryResponse)
    
    # Destroy a FTP directory response
    # 
    # *Arguments*:
    # 
    # * `ftp_directory_response`: Ftp directory response to destroy
    def finalize()
      CSFML.ftp_directory_response_destroy(@this) if @owned
    end
    
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
    def ok?
      CSFML.ftp_directory_response_is_ok(@this) != 0
    end
    
    # Get the status code of a FTP directory response
    # 
    # *Arguments*:
    # 
    # * `ftp_directory_response`: Ftp directory response
    # 
    # *Returns*: Status code
    def status
      CSFML.ftp_directory_response_get_status(@this)
    end
    
    # Get the full message contained in a FTP directory response
    # 
    # *Arguments*:
    # 
    # * `ftp_directory_response`: Ftp directory response
    # 
    # *Returns*: The response message
    def message
      ptr = CSFML.ftp_directory_response_get_message(@this)
      ptr ? String.new(ptr) : ""
    end
    
    # Get the directory returned in a FTP directory response
    # 
    # *Arguments*:
    # 
    # * `ftp_directory_response`: Ftp directory response
    # 
    # *Returns*: Directory name
    def directory
      ptr = CSFML.ftp_directory_response_get_directory(@this)
      ptr ? String.new(ptr) : ""
    end
    
  end

  class FtpListingResponse
    include Wrapper(CSFML::FtpListingResponse)
    
    # Destroy a FTP listing response
    # 
    # *Arguments*:
    # 
    # * `ftp_listing_response`: Ftp listing response to destroy
    def finalize()
      CSFML.ftp_listing_response_destroy(@this) if @owned
    end
    
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
    def ok?
      CSFML.ftp_listing_response_is_ok(@this) != 0
    end
    
    # Get the status code of a FTP listing response
    # 
    # *Arguments*:
    # 
    # * `ftp_listing_response`: Ftp listing response
    # 
    # *Returns*: Status code
    def status
      CSFML.ftp_listing_response_get_status(@this)
    end
    
    # Get the full message contained in a FTP listing response
    # 
    # *Arguments*:
    # 
    # * `ftp_listing_response`: Ftp listing response
    # 
    # *Returns*: The response message
    def message
      ptr = CSFML.ftp_listing_response_get_message(@this)
      ptr ? String.new(ptr) : ""
    end
    
    # Return the number of directory/file names contained in a FTP listing response
    # 
    # *Arguments*:
    # 
    # * `ftp_listing_response`: Ftp listing response
    # 
    # *Returns*: Total number of names available
    def count
      CSFML.ftp_listing_response_get_count(@this)
    end
    
    # Return a directory/file name contained in a FTP listing response
    # 
    # *Arguments*:
    # 
    # * `ftp_listing_response`: Ftp listing response
    # * `index`: Index of the name to get (in range [0 .. get_count])
    # 
    # *Returns*: The requested name
    def get_name(index: Int)
      index = LibC::SizeT.cast(index)
      ptr = CSFML.ftp_listing_response_get_name(@this, index)
      ptr ? String.new(ptr) : ""
    end
    
  end

  class FtpResponse
    include Wrapper(CSFML::FtpResponse)
    
    RestartMarkerReply = CSFML::FtpStatus::RestartMarkerReply
    ServiceReadySoon = CSFML::FtpStatus::ServiceReadySoon
    DataConnectionAlreadyOpened = CSFML::FtpStatus::DataConnectionAlreadyOpened
    OpeningDataConnection = CSFML::FtpStatus::OpeningDataConnection
    Ok = CSFML::FtpStatus::Ok
    PointlessCommand = CSFML::FtpStatus::PointlessCommand
    SystemStatus = CSFML::FtpStatus::SystemStatus
    DirectoryStatus = CSFML::FtpStatus::DirectoryStatus
    FileStatus = CSFML::FtpStatus::FileStatus
    HelpMessage = CSFML::FtpStatus::HelpMessage
    SystemType = CSFML::FtpStatus::SystemType
    ServiceReady = CSFML::FtpStatus::ServiceReady
    ClosingConnection = CSFML::FtpStatus::ClosingConnection
    DataConnectionOpened = CSFML::FtpStatus::DataConnectionOpened
    ClosingDataConnection = CSFML::FtpStatus::ClosingDataConnection
    EnteringPassiveMode = CSFML::FtpStatus::EnteringPassiveMode
    LoggedIn = CSFML::FtpStatus::LoggedIn
    FileActionOk = CSFML::FtpStatus::FileActionOk
    DirectoryOk = CSFML::FtpStatus::DirectoryOk
    NeedPassword = CSFML::FtpStatus::NeedPassword
    NeedAccountToLogIn = CSFML::FtpStatus::NeedAccountToLogIn
    NeedInformation = CSFML::FtpStatus::NeedInformation
    ServiceUnavailable = CSFML::FtpStatus::ServiceUnavailable
    DataConnectionUnavailable = CSFML::FtpStatus::DataConnectionUnavailable
    TransferAborted = CSFML::FtpStatus::TransferAborted
    FileActionAborted = CSFML::FtpStatus::FileActionAborted
    LocalError = CSFML::FtpStatus::LocalError
    InsufficientStorageSpace = CSFML::FtpStatus::InsufficientStorageSpace
    CommandUnknown = CSFML::FtpStatus::CommandUnknown
    ParametersUnknown = CSFML::FtpStatus::ParametersUnknown
    CommandNotImplemented = CSFML::FtpStatus::CommandNotImplemented
    BadCommandSequence = CSFML::FtpStatus::BadCommandSequence
    ParameterNotImplemented = CSFML::FtpStatus::ParameterNotImplemented
    NotLoggedIn = CSFML::FtpStatus::NotLoggedIn
    NeedAccountToStore = CSFML::FtpStatus::NeedAccountToStore
    FileUnavailable = CSFML::FtpStatus::FileUnavailable
    PageTypeUnknown = CSFML::FtpStatus::PageTypeUnknown
    NotEnoughMemory = CSFML::FtpStatus::NotEnoughMemory
    FilenameNotAllowed = CSFML::FtpStatus::FilenameNotAllowed
    InvalidResponse = CSFML::FtpStatus::InvalidResponse
    ConnectionFailed = CSFML::FtpStatus::ConnectionFailed
    ConnectionClosed = CSFML::FtpStatus::ConnectionClosed
    InvalidFile = CSFML::FtpStatus::InvalidFile
    # Destroy a FTP response
    # 
    # *Arguments*:
    # 
    # * `ftp_response`: Ftp response to destroy
    def finalize()
      CSFML.ftp_response_destroy(@this) if @owned
    end
    
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
    def ok?
      CSFML.ftp_response_is_ok(@this) != 0
    end
    
    # Get the status code of a FTP response
    # 
    # *Arguments*:
    # 
    # * `ftp_response`: Ftp response object
    # 
    # *Returns*: Status code
    def status
      CSFML.ftp_response_get_status(@this)
    end
    
    # Get the full message contained in a FTP response
    # 
    # *Arguments*:
    # 
    # * `ftp_response`: Ftp response object
    # 
    # *Returns*: The response message
    def message
      ptr = CSFML.ftp_response_get_message(@this)
      ptr ? String.new(ptr) : ""
    end
    
  end

  class Ftp
    include Wrapper(CSFML::Ftp)
    
    Binary = CSFML::FtpTransferMode::Binary
    Ascii = CSFML::FtpTransferMode::Ascii
    Ebcdic = CSFML::FtpTransferMode::Ebcdic
    # Create a new Ftp object
    # 
    # *Returns*: A new Ftp object
    def initialize()
      @owned = true
      @this = CSFML.ftp_create()
    end
    
    # Destroy a Ftp object
    # 
    # *Arguments*:
    # 
    # * `ftp`: Ftp object to destroy
    def finalize()
      CSFML.ftp_destroy(@this) if @owned
    end
    
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
    def connect(server: IpAddress, port: Int, timeout: Time)
      port = port.to_u16
      FtpResponse.wrap_ptr(CSFML.ftp_connect(@this, server, port, timeout))
    end
    
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
    def login_anonymous()
      FtpResponse.wrap_ptr(CSFML.ftp_login_anonymous(@this))
    end
    
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
    def login(user_name: String, password: String)
      FtpResponse.wrap_ptr(CSFML.ftp_login(@this, user_name, password))
    end
    
    # Close the connection with the server
    # 
    # *Arguments*:
    # 
    # * `ftp`: Ftp object
    # 
    # *Returns*: Server response to the request
    def disconnect()
      FtpResponse.wrap_ptr(CSFML.ftp_disconnect(@this))
    end
    
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
    def keep_alive()
      FtpResponse.wrap_ptr(CSFML.ftp_keep_alive(@this))
    end
    
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
    def working_directory
      FtpDirectoryResponse.wrap_ptr(CSFML.ftp_get_working_directory(@this))
    end
    
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
    def get_directory_listing(directory: String)
      FtpListingResponse.wrap_ptr(CSFML.ftp_get_directory_listing(@this, directory))
    end
    
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
    def change_directory(directory: String)
      FtpResponse.wrap_ptr(CSFML.ftp_change_directory(@this, directory))
    end
    
    # Go to the parent directory of the current one
    # 
    # *Arguments*:
    # 
    # * `ftp`: Ftp object
    # 
    # *Returns*: Server response to the request
    def parent_directory()
      FtpResponse.wrap_ptr(CSFML.ftp_parent_directory(@this))
    end
    
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
    def create_directory(name: String)
      FtpResponse.transfer_ptr(CSFML.ftp_create_directory(@this, name))
    end
    
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
    def delete_directory(name: String)
      FtpResponse.wrap_ptr(CSFML.ftp_delete_directory(@this, name))
    end
    
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
    def rename_file(file: String, new_name: String)
      FtpResponse.wrap_ptr(CSFML.ftp_rename_file(@this, file, new_name))
    end
    
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
    def delete_file(name: String)
      FtpResponse.wrap_ptr(CSFML.ftp_delete_file(@this, name))
    end
    
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
    def download(distant_file: String, dest_path: String, mode: FtpTransferMode)
      FtpResponse.wrap_ptr(CSFML.ftp_download(@this, distant_file, dest_path, mode))
    end
    
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
    def upload(local_file: String, dest_path: String, mode: FtpTransferMode)
      FtpResponse.wrap_ptr(CSFML.ftp_upload(@this, local_file, dest_path, mode))
    end
    
  end

  class HttpRequest
    include Wrapper(CSFML::HttpRequest)
    
    Get = CSFML::HttpMethod::Get
    Post = CSFML::HttpMethod::Post
    Head = CSFML::HttpMethod::Head
    Put = CSFML::HttpMethod::Put
    Delete = CSFML::HttpMethod::Delete
    # Create a new HTTP request
    # 
    # *Returns*: A new HttpRequest object
    def initialize()
      @owned = true
      @this = CSFML.http_request_create()
    end
    
    # Destroy a HTTP request
    # 
    # *Arguments*:
    # 
    # * `http_request`: HTTP request to destroy
    def finalize()
      CSFML.http_request_destroy(@this) if @owned
    end
    
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
    def set_field(field: String, value: String)
      CSFML.http_request_set_field(@this, field, value)
    end
    
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
    def method=(method: HttpMethod)
      CSFML.http_request_set_method(@this, method)
    end
    
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
    def uri=(uri: String)
      CSFML.http_request_set_uri(@this, uri)
    end
    
    # Set the HTTP version of a HTTP request
    # 
    # The HTTP version is 1.0 by default.
    # 
    # *Arguments*:
    # 
    # * `http_request`: HTTP request
    # * `major`: Major HTTP version number
    # * `minor`: Minor HTTP version number
    def set_http_version(major: Int, minor: Int)
      major = major.to_i32
      minor = minor.to_i32
      CSFML.http_request_set_http_version(@this, major, minor)
    end
    
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
    def body=(body: String)
      CSFML.http_request_set_body(@this, body)
    end
    
  end

  class HttpResponse
    include Wrapper(CSFML::HttpResponse)
    
    Ok = CSFML::HttpStatus::Ok
    Created = CSFML::HttpStatus::Created
    Accepted = CSFML::HttpStatus::Accepted
    NoContent = CSFML::HttpStatus::NoContent
    ResetContent = CSFML::HttpStatus::ResetContent
    PartialContent = CSFML::HttpStatus::PartialContent
    MultipleChoices = CSFML::HttpStatus::MultipleChoices
    MovedPermanently = CSFML::HttpStatus::MovedPermanently
    MovedTemporarily = CSFML::HttpStatus::MovedTemporarily
    NotModified = CSFML::HttpStatus::NotModified
    BadRequest = CSFML::HttpStatus::BadRequest
    Unauthorized = CSFML::HttpStatus::Unauthorized
    Forbidden = CSFML::HttpStatus::Forbidden
    NotFound = CSFML::HttpStatus::NotFound
    RangeNotSatisfiable = CSFML::HttpStatus::RangeNotSatisfiable
    InternalServerError = CSFML::HttpStatus::InternalServerError
    NotImplemented = CSFML::HttpStatus::NotImplemented
    BadGateway = CSFML::HttpStatus::BadGateway
    ServiceNotAvailable = CSFML::HttpStatus::ServiceNotAvailable
    GatewayTimeout = CSFML::HttpStatus::GatewayTimeout
    VersionNotSupported = CSFML::HttpStatus::VersionNotSupported
    InvalidResponse = CSFML::HttpStatus::InvalidResponse
    ConnectionFailed = CSFML::HttpStatus::ConnectionFailed
    # Destroy a HTTP response
    # 
    # *Arguments*:
    # 
    # * `http_response`: HTTP response to destroy
    def finalize()
      CSFML.http_response_destroy(@this) if @owned
    end
    
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
    def get_field(field: String)
      ptr = CSFML.http_response_get_field(@this, field)
      ptr ? String.new(ptr) : ""
    end
    
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
    def status
      CSFML.http_response_get_status(@this)
    end
    
    # Get the major HTTP version number of a HTTP response
    # 
    # *Arguments*:
    # 
    # * `http_response`: HTTP response
    # 
    # *Returns*: Major HTTP version number
    def major_version
      CSFML.http_response_get_major_version(@this)
    end
    
    # Get the minor HTTP version number of a HTTP response
    # 
    # *Arguments*:
    # 
    # * `http_response`: HTTP response
    # 
    # *Returns*: Minor HTTP version number
    def minor_version
      CSFML.http_response_get_minor_version(@this)
    end
    
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
    def body
      ptr = CSFML.http_response_get_body(@this)
      ptr ? String.new(ptr) : ""
    end
    
  end

  class Http
    include Wrapper(CSFML::Http)
    
    # Create a new Http object
    # 
    # *Returns*: A new Http object
    def initialize()
      @owned = true
      @this = CSFML.http_create()
    end
    
    # Destroy a Http object
    # 
    # *Arguments*:
    # 
    # * `http`: Http object to destroy
    def finalize()
      CSFML.http_destroy(@this) if @owned
    end
    
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
    def set_host(host: String, port: Int)
      port = port.to_u16
      CSFML.http_set_host(@this, host, port)
    end
    
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
    def send_request(request: HttpRequest, timeout: Time)
      HttpResponse.wrap_ptr(CSFML.http_send_request(@this, request, timeout))
    end
    
  end

  class Packet
    include Wrapper(CSFML::Packet)
    
    # Create a new packet
    # 
    # *Returns*: A new Packet object
    def initialize()
      @owned = true
      @this = CSFML.packet_create()
    end
    
    # Create a new packet by copying an existing one
    # 
    # *Arguments*:
    # 
    # * `packet`: Packet to copy
    # 
    # *Returns*: A new Packet object which is a copy of `packet`
    def dup()
      Packet.transfer_ptr(CSFML.packet_copy(@this))
    end
    
    # Destroy a packet
    # 
    # *Arguments*:
    # 
    # * `packet`: Packet to destroy
    def finalize()
      CSFML.packet_destroy(@this) if @owned
    end
    
    # Append data to the end of a packet
    # 
    # *Arguments*:
    # 
    # * `packet`: Packet object
    # * `data`: Pointer to the sequence of bytes to append
    # * `size_in_bytes`: Number of bytes to append
    def append(data: Void*, size_in_bytes: Int)
      size_in_bytes = LibC::SizeT.cast(size_in_bytes)
      CSFML.packet_append(@this, data, size_in_bytes)
    end
    
    # Clear a packet
    # 
    # After calling Clear, the packet is empty.
    # 
    # *Arguments*:
    # 
    # * `packet`: Packet object
    def clear()
      CSFML.packet_clear(@this)
    end
    
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
    def data
      CSFML.packet_get_data(@this)
    end
    
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
    def data_size
      CSFML.packet_get_data_size(@this)
    end
    
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
    def end_of_packet()
      CSFML.packet_end_of_packet(@this) != 0
    end
    
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
    def can_read()
      CSFML.packet_can_read(@this) != 0
    end
    
    # Functions to extract data from a packet
    # 
    # *Arguments*:
    # 
    # * `packet`: Packet object
    def read_bool()
      CSFML.packet_read_bool(@this) != 0
    end
    
    def read_int8()
      CSFML.packet_read_int8(@this)
    end
    
    def read_uint8()
      CSFML.packet_read_uint8(@this)
    end
    
    def read_int16()
      CSFML.packet_read_int16(@this)
    end
    
    def read_uint16()
      CSFML.packet_read_uint16(@this)
    end
    
    def read_int32()
      CSFML.packet_read_int32(@this)
    end
    
    def read_uint32()
      CSFML.packet_read_uint32(@this)
    end
    
    def read_float()
      CSFML.packet_read_float(@this)
    end
    
    def read_double()
      CSFML.packet_read_double(@this)
    end
    
    # Functions to insert data into a packet
    # 
    # *Arguments*:
    # 
    # * `packet`: Packet object
    def write_bool(p1: Bool)
      p1 = p1 ? 1 : 0
      CSFML.packet_write_bool(@this, p1)
    end
    
    def write_int8(p1: Int8)
      CSFML.packet_write_int8(@this, p1)
    end
    
    def write_uint8(p1: UInt8)
      CSFML.packet_write_uint8(@this, p1)
    end
    
    def write_int16(p1: Int16)
      CSFML.packet_write_int16(@this, p1)
    end
    
    def write_uint16(p1: Int)
      p1 = p1.to_u16
      CSFML.packet_write_uint16(@this, p1)
    end
    
    def write_int32(p1: Int32)
      CSFML.packet_write_int32(@this, p1)
    end
    
    def write_uint32(p1: UInt32)
      CSFML.packet_write_uint32(@this, p1)
    end
    
    def write_float(p1: Number)
      p1 = p1.to_f32
      CSFML.packet_write_float(@this, p1)
    end
    
    def write_double(p1: Float64)
      CSFML.packet_write_double(@this, p1)
    end
    
  end

  class SocketSelector
    include Wrapper(CSFML::SocketSelector)
    
    # Create a new selector
    # 
    # *Returns*: A new SocketSelector object
    def initialize()
      @owned = true
      @this = CSFML.socket_selector_create()
    end
    
    # Create a new socket selector by copying an existing one
    # 
    # *Arguments*:
    # 
    # * `selector`: Socket selector to copy
    # 
    # *Returns*: A new SocketSelector object which is a copy of `selector`
    def dup()
      SocketSelector.transfer_ptr(CSFML.socket_selector_copy(@this))
    end
    
    # Destroy a socket selector
    # 
    # *Arguments*:
    # 
    # * `selector`: Socket selector to destroy
    def finalize()
      CSFML.socket_selector_destroy(@this) if @owned
    end
    
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
    def add_tcp_listener(socket: TcpListener)
      CSFML.socket_selector_add_tcp_listener(@this, socket)
    end
    
    def add_tcp_socket(socket: TcpSocket)
      CSFML.socket_selector_add_tcp_socket(@this, socket)
    end
    
    def add_udp_socket(socket: UdpSocket)
      CSFML.socket_selector_add_udp_socket(@this, socket)
    end
    
    # Remove a socket from a socket selector
    # 
    # This function doesn't destroy the socket, it simply
    # removes the pointer that the selector has to it.
    # 
    # *Arguments*:
    # 
    # * `selector`: Socket selector object
    # * `socket`: POointer to the socket to remove
    def remove_tcp_listener(socket: TcpListener)
      CSFML.socket_selector_remove_tcp_listener(@this, socket)
    end
    
    def remove_tcp_socket(socket: TcpSocket)
      CSFML.socket_selector_remove_tcp_socket(@this, socket)
    end
    
    def remove_udp_socket(socket: UdpSocket)
      CSFML.socket_selector_remove_udp_socket(@this, socket)
    end
    
    # Remove all the sockets stored in a selector
    # 
    # This function doesn't destroy any instance, it simply
    # removes all the pointers that the selector has to
    # external sockets.
    # 
    # *Arguments*:
    # 
    # * `selector`: Socket selector object
    def clear()
      CSFML.socket_selector_clear(@this)
    end
    
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
    def wait(timeout: Time)
      CSFML.socket_selector_wait(@this, timeout) != 0
    end
    
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
    def is_tcp_listener_ready(socket: TcpListener)
      CSFML.socket_selector_is_tcp_listener_ready(@this, socket) != 0
    end
    
    def is_tcp_socket_ready(socket: TcpSocket)
      CSFML.socket_selector_is_tcp_socket_ready(@this, socket) != 0
    end
    
    def is_udp_socket_ready(socket: UdpSocket)
      CSFML.socket_selector_is_udp_socket_ready(@this, socket) != 0
    end
    
  end

  class TcpListener
    include Wrapper(CSFML::TcpListener)
    
    # Create a new TCP listener
    # 
    # *Returns*: A new TcpListener object
    def initialize()
      @owned = true
      @this = CSFML.tcp_listener_create()
    end
    
    # Destroy a TCP listener
    # 
    # *Arguments*:
    # 
    # * `listener`: TCP listener to destroy
    def finalize()
      CSFML.tcp_listener_destroy(@this) if @owned
    end
    
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
    def blocking=(blocking: Bool)
      blocking = blocking ? 1 : 0
      CSFML.tcp_listener_set_blocking(@this, blocking)
    end
    
    # Tell whether a TCP listener is in blocking or non-blocking mode
    # 
    # *Arguments*:
    # 
    # * `listener`: TCP listener object
    # 
    # *Returns*: True if the socket is blocking, False otherwise
    def blocking?
      CSFML.tcp_listener_is_blocking(@this) != 0
    end
    
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
    def local_port
      CSFML.tcp_listener_get_local_port(@this)
    end
    
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
    def listen(port: Int)
      port = port.to_u16
      CSFML.tcp_listener_listen(@this, port)
    end
    
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
    def accept(connected: TcpSocket*)
      CSFML.tcp_listener_accept(@this, connected)
    end
    
  end

  class TcpSocket
    include Wrapper(CSFML::TcpSocket)
    
    # Create a new TCP socket
    # 
    # *Returns*: A new TcpSocket object
    def initialize()
      @owned = true
      @this = CSFML.tcp_socket_create()
    end
    
    # Destroy a TCP socket
    # 
    # *Arguments*:
    # 
    # * `socket`: TCP socket to destroy
    def finalize()
      CSFML.tcp_socket_destroy(@this) if @owned
    end
    
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
    def blocking=(blocking: Bool)
      blocking = blocking ? 1 : 0
      CSFML.tcp_socket_set_blocking(@this, blocking)
    end
    
    # Tell whether a TCP socket is in blocking or non-blocking mode
    # 
    # *Arguments*:
    # 
    # * `socket`: TCP socket object
    # 
    # *Returns*: True if the socket is blocking, False otherwise
    def blocking?
      CSFML.tcp_socket_is_blocking(@this) != 0
    end
    
    # Get the port to which a TCP socket is bound locally
    # 
    # If the socket is not connected, this function returns 0.
    # 
    # *Arguments*:
    # 
    # * `socket`: TCP socket object
    # 
    # *Returns*: Port to which the socket is bound
    def local_port
      CSFML.tcp_socket_get_local_port(@this)
    end
    
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
    def remote_address
      CSFML.tcp_socket_get_remote_address(@this)
    end
    
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
    def remote_port
      CSFML.tcp_socket_get_remote_port(@this)
    end
    
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
    def connect(host: IpAddress, port: Int, timeout: Time)
      port = port.to_u16
      CSFML.tcp_socket_connect(@this, host, port, timeout)
    end
    
    # Disconnect a TCP socket from its remote peer
    # 
    # This function gracefully closes the connection. If the
    # socket is not connected, this function has no effect.
    # 
    # *Arguments*:
    # 
    # * `socket`: TCP socket object
    def disconnect()
      CSFML.tcp_socket_disconnect(@this)
    end
    
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
    def send(data: Void*, size: Int)
      size = LibC::SizeT.cast(size)
      CSFML.tcp_socket_send(@this, data, size)
    end
    
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
    def send_partial(data: Void*, size: Int, sent: LibC::SizeT*)
      size = LibC::SizeT.cast(size)
      CSFML.tcp_socket_send_partial(@this, data, size, sent)
    end
    
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
    def receive(data: Void*, max_size: Int, size_received: LibC::SizeT*)
      max_size = LibC::SizeT.cast(max_size)
      CSFML.tcp_socket_receive(@this, data, max_size, size_received)
    end
    
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
    def send_packet(packet: Packet)
      CSFML.tcp_socket_send_packet(@this, packet)
    end
    
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
    def receive_packet(packet: Packet)
      CSFML.tcp_socket_receive_packet(@this, packet)
    end
    
  end

  class UdpSocket
    include Wrapper(CSFML::UdpSocket)
    
    # Create a new UDP socket
    # 
    # *Returns*: A new UdpSocket object
    def initialize()
      @owned = true
      @this = CSFML.udp_socket_create()
    end
    
    # Destroy a UDP socket
    # 
    # *Arguments*:
    # 
    # * `socket`: UDP socket to destroy
    def finalize()
      CSFML.udp_socket_destroy(@this) if @owned
    end
    
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
    def blocking=(blocking: Bool)
      blocking = blocking ? 1 : 0
      CSFML.udp_socket_set_blocking(@this, blocking)
    end
    
    # Tell whether a UDP socket is in blocking or non-blocking mode
    # 
    # *Arguments*:
    # 
    # * `socket`: UDP socket object
    # 
    # *Returns*: True if the socket is blocking, False otherwise
    def blocking?
      CSFML.udp_socket_is_blocking(@this) != 0
    end
    
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
    def local_port
      CSFML.udp_socket_get_local_port(@this)
    end
    
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
    def bind(port: Int)
      port = port.to_u16
      CSFML.udp_socket_bind(@this, port)
    end
    
    # Unbind a UDP socket from the local port to which it is bound
    # 
    # The port that the socket was previously using is immediately
    # available after this function is called. If the
    # socket is not bound to a port, this function has no effect.
    # 
    # *Arguments*:
    # 
    # * `socket`: UDP socket object
    def unbind()
      CSFML.udp_socket_unbind(@this)
    end
    
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
    def send(data: Void*, size: Int, address: IpAddress, port: Int)
      size = LibC::SizeT.cast(size)
      port = port.to_u16
      CSFML.udp_socket_send(@this, data, size, address, port)
    end
    
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
    def receive(data: Void*, max_size: Int, size_received: LibC::SizeT*, address: IpAddress*, port: UInt16*)
      max_size = LibC::SizeT.cast(max_size)
      CSFML.udp_socket_receive(@this, data, max_size, size_received, address, port)
    end
    
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
    def send_packet(packet: Packet, address: IpAddress, port: Int)
      port = port.to_u16
      CSFML.udp_socket_send_packet(@this, packet, address, port)
    end
    
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
    def receive_packet(packet: Packet, address: IpAddress*, port: UInt16*)
      CSFML.udp_socket_receive_packet(@this, packet, address, port)
    end
    
    # Return the maximum number of bytes that can be
    # sent in a single UDP datagram
    # 
    # *Returns*: The maximum size of a UDP datagram (message)
    def self.max_datagram_size()
      CSFML.udp_socket_max_datagram_size()
    end
    
  end

  # Enumeration of transfer modes
  #
  # * Ftp::Binary
  # * Ftp::Ascii
  # * Ftp::Ebcdic
  alias FtpTransferMode = CSFML::FtpTransferMode

  # Status codes possibly returned by a FTP response
  #
  # * FtpResponse::RestartMarkerReply
  # * FtpResponse::ServiceReadySoon
  # * FtpResponse::DataConnectionAlreadyOpened
  # * FtpResponse::OpeningDataConnection
  # * FtpResponse::Ok
  # * FtpResponse::PointlessCommand
  # * FtpResponse::SystemStatus
  # * FtpResponse::DirectoryStatus
  # * FtpResponse::FileStatus
  # * FtpResponse::HelpMessage
  # * FtpResponse::SystemType
  # * FtpResponse::ServiceReady
  # * FtpResponse::ClosingConnection
  # * FtpResponse::DataConnectionOpened
  # * FtpResponse::ClosingDataConnection
  # * FtpResponse::EnteringPassiveMode
  # * FtpResponse::LoggedIn
  # * FtpResponse::FileActionOk
  # * FtpResponse::DirectoryOk
  # * FtpResponse::NeedPassword
  # * FtpResponse::NeedAccountToLogIn
  # * FtpResponse::NeedInformation
  # * FtpResponse::ServiceUnavailable
  # * FtpResponse::DataConnectionUnavailable
  # * FtpResponse::TransferAborted
  # * FtpResponse::FileActionAborted
  # * FtpResponse::LocalError
  # * FtpResponse::InsufficientStorageSpace
  # * FtpResponse::CommandUnknown
  # * FtpResponse::ParametersUnknown
  # * FtpResponse::CommandNotImplemented
  # * FtpResponse::BadCommandSequence
  # * FtpResponse::ParameterNotImplemented
  # * FtpResponse::NotLoggedIn
  # * FtpResponse::NeedAccountToStore
  # * FtpResponse::FileUnavailable
  # * FtpResponse::PageTypeUnknown
  # * FtpResponse::NotEnoughMemory
  # * FtpResponse::FilenameNotAllowed
  # * FtpResponse::InvalidResponse
  # * FtpResponse::ConnectionFailed
  # * FtpResponse::ConnectionClosed
  # * FtpResponse::InvalidFile
  alias FtpStatus = CSFML::FtpStatus

  # Enumerate the available HTTP methods for a request
  #
  # * HttpRequest::Get
  # * HttpRequest::Post
  # * HttpRequest::Head
  # * HttpRequest::Put
  # * HttpRequest::Delete
  alias HttpMethod = CSFML::HttpMethod

  # Enumerate all the valid status codes for a response
  #
  # * HttpResponse::Ok
  # * HttpResponse::Created
  # * HttpResponse::Accepted
  # * HttpResponse::NoContent
  # * HttpResponse::ResetContent
  # * HttpResponse::PartialContent
  # * HttpResponse::MultipleChoices
  # * HttpResponse::MovedPermanently
  # * HttpResponse::MovedTemporarily
  # * HttpResponse::NotModified
  # * HttpResponse::BadRequest
  # * HttpResponse::Unauthorized
  # * HttpResponse::Forbidden
  # * HttpResponse::NotFound
  # * HttpResponse::RangeNotSatisfiable
  # * HttpResponse::InternalServerError
  # * HttpResponse::NotImplemented
  # * HttpResponse::BadGateway
  # * HttpResponse::ServiceNotAvailable
  # * HttpResponse::GatewayTimeout
  # * HttpResponse::VersionNotSupported
  # * HttpResponse::InvalidResponse
  # * HttpResponse::ConnectionFailed
  alias HttpStatus = CSFML::HttpStatus

  # Define the status that can be returned by the socket functions
  #
  # * Socket::Done
  # * Socket::NotReady
  # * Socket::Partial
  # * Socket::Disconnected
  # * Socket::Error
  alias SocketStatus = CSFML::SocketStatus

  class Socket
    Done = CSFML::SocketStatus::Done
    NotReady = CSFML::SocketStatus::NotReady
    Partial = CSFML::SocketStatus::Partial
    Disconnected = CSFML::SocketStatus::Disconnected
    Error = CSFML::SocketStatus::Error
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
  def ip_address(address: String)
    CSFML.ip_address_from_string(address)
  end
  
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
  def ip_address(byte0: UInt8, byte1: UInt8, byte2: UInt8, byte3: UInt8)
    CSFML.ip_address_from_bytes(byte0, byte1, byte2, byte3)
  end
  
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
  def ip_address(address: UInt32)
    CSFML.ip_address_from_integer(address)
  end
  
end
