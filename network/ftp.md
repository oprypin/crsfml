# File transfers with FTP

## FTP for dummies

If you know what FTP is, and just want to know how to use the FTP class that SFML provides, you can skip this section.

FTP (*File Transfer Protocol*) is a simple protocol that allows manipulation of files and directories on a remote server. The protocol consists of commands such as "create directory", "delete file", "download file", etc. You can't send FTP commands to any remote computer, it needs to have an FTP server running which can understand and execute the commands that clients send.

So what can you do with FTP, and how can it be helpful to your program? Basically, with FTP you can access existing remote file systems, or even create your own. This can be useful if you want your network game to download resources (maps, images, ...) from a server, or your program to update itself automatically when it's connected to the internet.

If you want to know more about the FTP protocol, the [Wikipedia article](http://en.wikipedia.org/wiki/File_Transfer_Protocol "FTP on wikipedia") provides more detailed information than this short introduction.

## The FTP client class

The class provided by CrSFML is [Ftp]({{book.api}}/Ftp.html) (surprising, isn't it?). It's a client, which means that it can connect to an FTP server, send commands to it and upload or download files.

Every method of the [Ftp]({{book.api}}/Ftp.html) class wraps an FTP command, and returns a standard FTP response. An FTP response contains a status code (similar to HTTP status codes but not identical), and a message that informs the user of what happened. FTP responses are encapsulated in the [Ftp::Response]({{book.api}}/Ftp::Response.html) class.

```crystal
ftp = SF::Ftp.new

...

response = ftp.login("username", "password") # just an example, could be any method

puts "Response status: #{response.status}"
puts "Response message: #{response.message}"
```

The status code can be used to check whether the command was successful or failed: Codes lower than 400 represent success, all others represent errors. You can use the `ok?` method as a shortcut to test a status code for success.

```crystal
response = ftp.login("username", "password")
if response.ok?
  # success!
else
  # error...
end
```

If you don't care about the details of the response, you can check for success with even less code:

```crystal
if ftp.login("username", "password").ok?
  # success!
else
  # error...
end
```

For readability, these checks won't be performed in the following examples in this tutorial. Don't forget to perform them in your code!

Now that you understand how the class works, let's have a look at what it can do.

## Connecting to the FTP server

The first thing to do is connect to an FTP server.

```crystal
ftp = SF::Ftp.new
ip_address = SF.ip_address("ftp.myserver.org")
ftp.connect(ip_address)
```

The server address can be any valid [IpAddress]({{book.api}}/IpAddress.html): A URL, an IP address, a network name, ...

The standard port for FTP is 21. If, for some reason, your server uses a different port, you can specify it as an additional argument:

```crystal
ftp = SF::Ftp.new
ip_address = SF.ip_address("ftp.myserver.org")
ftp.connect(ip_address, 45000)
```

You can also pass a third parameter, which is a time out value. This prevents you from having to wait forever (or at least a very long time) if the server doesn't respond.

```crystal
ftp = SF::Ftp.new
ip_address = SF.ip_address("ftp.myserver.org")
ftp.connect(ip_address, 21, SF.seconds(5))
```

Once you're connected to the server, the next step is to authenticate yourself:

```crystal
# authenticate with name and password
ftp.login("username", "password")

# or login anonymously, if the server allows it
ftp.login
```

## FTP commands

Here is a short description of all the commands available in the [Ftp]({{book.api}}/Ftp.html) class. Remember one thing: All these commands are performed relative to the *current working directory*, exactly as if you were executing file or directory commands in a console on your operating system.

Getting the current working directory:

```crystal
response = ftp.working_directory

if response.ok?
  puts "Current directory: " + response.directory
end
```

[Ftp::DirectoryResponse]({{book.api}}/Ftp::DirectoryResponse.html) is a specialized [Ftp::Response]({{book.api}}/Ftp::Response.html) that also contains the requested directory.

Getting the list of directories and files contained in the current directory:

```crystal
response = ftp.get_directory_listing

if response.ok?
  listing = response.listing
  listing.each do |item|
    puts "- " + item
  end
end

# you can also get the listing of a sub-directory of the current directory:
response = ftp.get_directory_listing("subfolder")
```

[Ftp::ListingResponse]({{book.api}}/Ftp::ListingResponse.html) is a specialized [Ftp::Response]({{book.api}}/Ftp::Response.html) that also contains the requested directory/file names.

Changing the current directory:

```crystal
ftp.change_directory("path/to/new_directory") # the given path is relative to the current directory
```

Going to the parent directory of the current one:

```crystal
ftp.parent_directory
```

Creating a new directory (as a child of the current one):

```crystal
ftp.create_directory("name_of_new_directory")
```

Deleting an existing directory:

```crystal
ftp.delete_directory("name_of_directory_to_delete")
```

Renaming an existing file:

```crystal
ftp.rename_file("old_name.txt", "new_name.txt")
```

Deleting an existing file:

```crystal
ftp.delete_file("file_name.txt")
```

Downloading (receiving from the server) a file:

```crystal
ftp.download("remote_file_name.txt", "local/destination/path", SF::Ftp::Ascii)
```

The last argument is the transfer mode. It can be either Ascii (for text files), Ebcdic (for text files using the EBCDIC character set) or Binary (for non-text files). The Ascii and Ebcdic modes can transform the file (line endings, encoding) during the transfer to match the client environment. The Binary mode is a direct byte-for-byte transfer.

Uploading (sending to the server) a file:

```crystal
ftp.upload("local_file_name.pdf", "remote/destination/path", SF::Ftp::Binary)
```

FTP servers usually close connections that are inactive for a while. If you want to avoid being disconnected, you can send a no-op command periodically:

```crystal
ftp.keep_alive()
```

## Disconnecting from the FTP server

You can close the connection with the server at any moment with the `disconnect` method.

```crystal
ftp.disconnect()
```
