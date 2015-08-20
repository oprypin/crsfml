# File transfers with FTP

## FTP for dummies

If you know what FTP is, and just want to know how to use the FTP class that SFML provides, you can skip this section. 

FTP (*File Transfer Protocol*) is a simple protocol that allows manipulation of files and directories on a remote server. The protocol consists of commands such as "create directory", "delete file", "download file", etc. You can't send FTP commands to any remote computer, it needs to have an FTP server running which can understand and execute the commands that clients send. 

So what can you do with FTP, and how can it be helpful to your program? Basically, with FTP you can access existing remote file systems, or even create your own. This can be useful if you want your network game to download resources (maps, images, ...) from a server, or your program to update itself automatically when it's connected to the internet. 

If you want to know more about the FTP protocol, the [Wikipedia article](http://en.wikipedia.org/wiki/File_Transfer_Protocol "FTP on wikipedia") provides more detailed information than this short introduction. 

## The FTP client class

The class provided by SFML is [Ftp]({{book.api}}/Ftp.html) (surprising, isn't it?). It's a client, which means that it can connect to an FTP server, send commands to it and upload or download files. 

Every function of the [Ftp]({{book.api}}/Ftp.html) class wraps an FTP command, and returns a standard FTP response. An FTP response contains a status code (similar to HTTP status codes but not identical), and a message that informs the user of what happened. FTP responses are encapsulated in the [Ftp::Response]({{book.api}}/Ftp::Response.html) class. 

```
#include <SFML/Network.hpp>

sf::Ftp ftp;
...
sf::Ftp::Response response = ftp.login(); // just an example, could be any function

std::cout << "Response status: " << response.getStatus() << std::endl;
std::cout << "Response message: " << response.getMessage() << std::endl;
```

The status code can be used to check whether the command was successful or failed: Codes lower than 400 represent success, all others represent errors. You can use the `isOk()` function as a shortcut to test a status code for success. 

```
sf::Ftp::Response response = ftp.login();
if (response.isOk())
{
    // success!
}
else
{
    // error...
}
```

If you don't care about the details of the response, you can check for success with even less code: 

```
if (ftp.login().isOk())
{
    // success!
}
else
{
    // error...
}
```

For readability, these checks won't be performed in the following examples in this tutorial. Don't forget to perform them in your code! 

Now that you understand how the class works, let's have a look at what it can do. 

## Connecting to the FTP server

The first thing to do is connect to an FTP server. 

```
sf::Ftp ftp;
ftp.connect("ftp.myserver.org");
```

The server address can be any valid [IpAddress]({{book.api}}/IpAddress.html): A URL, an IP address, a network name, ... 

The standard port for FTP is 21. If, for some reason, your server uses a different port, you can specify it as an additional argument: 

```
sf::Ftp ftp;
ftp.connect("ftp.myserver.org", 45000);
```

You can also pass a third parameter, which is a time out value. This prevents you from having to wait forever (or at least a very long time) if the server doesn't respond. 

```
sf::Ftp ftp;
ftp.connect("ftp.myserver.org", 21, sf::seconds(5));
```

Once you're connected to the server, the next step is to authenticate yourself: 

```
// authenticate with name and password
ftp.login("username", "password");

// or login anonymously, if the server allows it
ftp.login();
```

## FTP commands

Here is a short description of all the commands available in the [Ftp]({{book.api}}/Ftp.html) class. Remember one thing: All these commands are performed relative to the *current working directory*, exactly as if you were executing file or directory commands in a console on your operating system. 

Getting the current working directory: 

```
sf::Ftp::DirectoryResponse response = ftp.getWorkingDirectory();
if (response.isOk())
    std::cout << "Current directory: " << response.getDirectory() << std::endl;
```

[Ftp::DirectoryResponse]({{book.api}}/Ftp::DirectoryResponse.html) is a specialized [Ftp::Response]({{book.api}}/Ftp::Response.html) that also contains the requested directory. 

Getting the list of directories and files contained in the current directory: 

```
sf::Ftp::ListingResponse response = ftp.getDirectoryListing();
if (response.isOk())
{
    const std::vector<std::string>& listing = response.getListing();
    for (std::vector<std::string>::const_iterator it = listing.begin(); it != listing.end(); ++it)
        std::cout << "- " << *it << std::endl;
}

// you can also get the listing of a sub-directory of the current directory:
response = ftp.getDirectoryListing("subfolder");
```

[Ftp::ListingResponse]({{book.api}}/Ftp::ListingResponse.html) is a specialized [Ftp::Response]({{book.api}}/Ftp::Response.html) that also contains the requested directory/file names. 

Changing the current directory: 

```
ftp.changeDirectory("path/to/new_directory"); // the given path is relative to the current directory
```

Going to the parent directory of the current one: 

```
ftp.parentDirectory();
```

Creating a new directory (as a child of the current one): 

```
ftp.createDirectory("name_of_new_directory");
```

Deleting an existing directory: 

```
ftp.deleteDirectory("name_of_directory_to_delete");
```

Renaming an existing file: 

```
ftp.renameFile("old_name.txt", "new_name.txt");
```

Deleting an existing file: 

```
ftp.deleteFile("file_name.txt");
```

Downloading (receiving from the server) a file: 

```
ftp.download("remote_file_name.txt", "local/destination/path", sf::Ftp::Ascii);
```

The last argument is the transfer mode. It can be either Ascii (for text files), Ebcdic (for text files using the EBCDIC character set) or Binary (for non-text files). The Ascii and Ebcdic modes can transform the file (line endings, encoding) during the transfer to match the client environment. The Binary mode is a direct byte-for-byte transfer. 

Uploading (sending to the server) a file: 

```
ftp.upload("local_file_name.pdf", "remote/destination/path", sf::Ftp::Binary);
```

FTP servers usually close connections that are inactive for a while. If you want to avoid being disconnected, you can send a no-op command periodically: 

```
ftp.keepAlive();
```

## Disconnecting from the FTP server

You can close the connection with the server at any moment with the `disconnect` function. 

```
ftp.disconnect();
```

