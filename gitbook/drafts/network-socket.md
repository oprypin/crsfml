# Communicating with sockets

## Sockets

A socket is the interface between your application and the outside world: through a socket, you can send and receive data. Therefore, any network program will most likely have to deal with sockets, they are the central element of network communication. 

There are several kinds of sockets, each providing specific features. SFML implements the most common ones: TCP sockets and UDP sockets. 

## TCP vs UDP

It is important to know what TCP and UDP sockets can do, and what they can't do, so that you can choose the best socket type according to the requirements of your application. 

The main difference is that TCP sockets are connection-based. You can't send or receive anything until you are connected to another TCP socket on the remote machine. Once connected, a TCP socket can only send and receive to/from the remote machine. This means that you'll need one TCP socket for each client in your application.  
UDP is not connection-based, you can send and receive to/from anyone at any time with the same socket. 

The second difference is that TCP is reliable unlike UDP. It ensures that what you send is always received, without corruption and in the same order. UDP performs less checks, and doesn't provide any reliability: what you send might be received multiple times (duplication), or in a different order, or be lost and never reach the remote computer. However, UDP does guarantee that data which is received is always valid (not corrupted).  
UDP may seem scary, but keep in mind that *almost all the time*, data arrives correctly and in the right order. 

The third difference is a direct consequence of the second one: UDP is faster and more lightweight than TCP. Because it has less requirements, thus less overhead. 

The last difference is about the way data is transported. TCP is a *stream* protocol: there's no message boundary, if you send "Hello" and then "SFML", the remote machine might receive "HelloSFML", "Hel" + "loSFML", or even "He" + "loS" + "FML".  
UDP is a *datagram* protocol. Datagrams are packets that can't be mixed with each other. If you receive a datagram with UDP, it is guaranteed to be exactly the same as it was sent. 

Oh, and one last thing: since UDP is not connection-based, it allows broadcasting messages to multiple recipients, or even to an entire network. The one-to-one communication of TCP sockets doesn't allow that. 

## Connecting a TCP socket

As you can guess, this part is specific to TCP sockets. There are two sides to a connection: the one that waits for the incoming connection (let's call it the server), and the one that triggers it (let's call it the client). 

On client side, things are simple: the user just needs to have a [TcpSocket]({{book.api}}/TcpSocket.html) and call its `connect` method to start the connection attempt. 

```
#include <SFML/Network.hpp>

SF::TcpSocket socket;
SF::Socket::Status status = socket.connect("192.168.0.5", 53000);
if (status != SF::Socket::Done)
{
    // error...
}
```

The first argument is the address of the host to connect to. It is an [IpAddress]({{book.api}}/IpAddress.html), which can represent any valid address: a URL, an IP address, or a network host name. See its documentation for more details. 

The second argument is the port to connect to on the remote machine. The connection will succeed only if the server is accepting connections on that port. 

There's an optional third argument, a time out value. If set, and the connection attempt doesn't succeed before the time out is over, the method returns an error. If not specified, the default operating system time out is used. 

Once connected, you can retrieve the address and port of the remote computer if needed, with the `getRemoteAddress()` and `getRemotePort()` methods. 

All methods of socket classes are blocking by default. This means that your program (more specifically the thread that contains the method call) will be stuck until the operation is complete. This is important because some methods may take very long: For example, trying to connect to an unreachable host will only return after a few seconds, receiving will wait until there's data available, etc.  
You can change this behavior and make all methods non-blocking by using the `setBlocking` method of the socket. See the next chapters for more details. 

On the server side, a few more things have to be done. Multiple sockets are required: One that listens for incoming connections, and one for each connected client. 

To listen for connections, you must use the special [TcpListener]({{book.api}}/TcpListener.html) class. Its only role is to wait for incoming connection attempts on a given port, it can't send or receive data. 

```
SF::TcpListener listener;

// bind the listener to a port
if (listener.listen(53000) != SF::Socket::Done)
{
    // error...
}

// accept a new connection
SF::TcpSocket client;
if (listener.accept(client) != SF::Socket::Done)
{
    // error...
}

// use "client" to communicate with the connected client,
// and continue to accept new connections with the listener
```

The `accept` method blocks until a connection attempt arrives (unless the socket is configured as non-blocking). When it happens, it initializes the given socket and returns. The socket can now be used to communicate with the new client, and the listener can go back to waiting for another connection attempt. 

After a successful call to `connect` (on client side) and `accept` (on server side), the communication is established and both sockets are ready to exchange data. 

## Binding a UDP socket

UDP sockets need not be connected, however you need to bind them to a specific port if you want to be able to receive data on that port. A UDP socket cannot receive on multiple ports simultaneously. 

```
SF::UdpSocket socket;

// bind the socket to a port
if (socket.bind(54000) != SF::Socket::Done)
{
    // error...
}
```

After binding the socket to a port, it's ready to receive data on that port. If you want the operating system to bind the socket to a free port automatically, you can pass `SF::Socket::AnyPort`, and then retrieve the chosen port with `socket.getLocalPort()`. 

UDP sockets that send data don't need to do anything before sending. 

## Sending and receiving data

Sending and receiving data is done in the same way for both types of sockets. The only difference is that UDP has two extra arguments: the address and port of the sender/recipient. There are two different methods for each operation: the low-level one, that sends/receives a raw array of bytes, and the higher-level one, which uses the [Packet]({{book.api}}/Packet.html) class. See the [tutorial on packets](network-packet.md "Tutorial on packets") for more details about this class. In this tutorial, we'll only explain the low-level methods. 

To send data, you must call the `send` method with a pointer to the data that you want to send, and the number of bytes to send. 

```
char data[100] = ...;

// TCP socket:
if (socket.send(data, 100) != SF::Socket::Done)
{
    // error...
}

// UDP socket:
SF::IpAddress recipient = "192.168.0.5";
unsigned short port = 54000;
if (socket.send(data, 100, recipient, port) != SF::Socket::Done)
{
    // error...
}
```

The `send` methods take a `void*` pointer, so you can pass the address of anything. However, it is generally a bad idea to send something other than an array of bytes because native types with a size larger than 1 byte are not guaranteed to be the same on every machine: Types such as int or long may have a different size, and/or a different endianness. Therefore, such types cannot be exchanged reliably across different systems. This problem is explained (and solved) in the [tutorial on packets](network-packet.md "Tutorial on packets"). 

With UDP you can broadcast a message to an entire sub-network in a single call: to do so you can use the special address `SF::IpAddress::Broadcast`. 

There's another thing to keep in mind with UDP: Since data is sent in datagrams and the size of these datagrams has a limit, you are not allowed to exceed it. Every call to `send` must send less that `SF::UdpSocket::MaxDatagramSize` bytes -- which is a little less than 2^16 (65536) bytes. 

To receive data, you must call the `receive` method: 

```
char data[100];
std::size_t received;

// TCP socket:
if (socket.receive(data, 100, received) != SF::Socket::Done)
{
    // error...
}
std::cout << "Received " << received << " bytes" << std::endl;

// UDP socket:
SF::IpAddress sender;
unsigned short port;
if (socket.receive(data, 100, received, sender, port) != SF::Socket::Done)
{
    // error...
}
std::cout << "Received " << received << " bytes from " << sender << " on port " << port << std::endl;
```

It is important to keep in mind that if the socket is in blocking mode, `receive` will wait until something is received, blocking the thread that called it (and thus possibly the whole program). 

The first two arguments specify the buffer to which the received bytes are to be copied, along with its maximum size. The third argument is a variable that will contain the actual number of bytes received after the method returns.  
With UDP sockets, the last two arguments will contain the address and port of the sender after the method returns. They can be used later if you want to send a response. 

These methods are low-level, and you should use them only if you have a very good reason to do so. A more robust and flexible approach involves using [packets](network-packet.md "Tutorial on packets"). 

## Blocking on a group of sockets

Blocking on a single socket can quickly become annoying, because you will most likely have to handle more than one client. You most likely don't want socket A to block your program while socket B has received something that could be processed. What you would like is to block on multiple sockets at once, i.e. waiting until *any of them* has received something. This is possible with socket selectors, represented by the [SocketSelector]({{book.api}}/SocketSelector.html) class. 

A selector can monitor all types of sockets: [TcpSocket]({{book.api}}/TcpSocket.html), [UdpSocket]({{book.api}}/UdpSocket.html), and [TcpListener]({{book.api}}/TcpListener.html). To add a socket to a selector, use its `add` method: 

```
SF::TcpSocket socket;

SF::SocketSelector selector;
selector.add(socket);
```

A selector is not a socket container. It only references (points to) the sockets that you add, it doesn't store them. There is no way to retrieve or count the sockets that you put inside. Instead, it is up to you to have your own separate socket storage (like a `std::vector` or a `std::list`). 

Once you have filled the selector with all the sockets that you want to monitor, you must call its `wait` method to wait until any one of them has received something (or has triggered an error). You can also pass an optional time out value, so that the method will fail if nothing has been received after a certain period of time -- this avoids staying stuck forever if nothing happens. 

```
if (selector.wait(SF::seconds(10)))
{
    // received something
}
else
{
    // timeout reached, nothing was received...
}
```

If the `wait` method returns `true`, it means that one or more socket(s) have received something, and you can safely call `receive` on the socket(s) with pending data without having them block. If the socket is a [TcpListener]({{book.api}}/TcpListener.html), it means that an incoming connection is ready to be accepted and that you can call its `accept` method without having it block. 

Since the selector is not a socket container, it cannot return the sockets that are ready to receive. Instead, you must test each candidate socket with the `isReady` method: 

```
if (selector.wait(SF::seconds(10)))
{
    // for each socket... <-- pseudo-code because I don't know how you store your sockets :)
    {
        if (selector.isReady(socket))
        {
            // this socket is ready, you can receive (or accept if it's a listener)
            socket.receive(...);
        }
    }
}
```

You can have a look at the API documentation of the [SocketSelector]({{book.api}}/SocketSelector.html) class for a working example of how to use a selector to handle connections and messages from multiple clients. 

As a bonus, the time out capability of `Selector::wait` allows you to implement a receive-with-timeout method, which is not directly available in the socket classes, very easily: 

```
SF::Socket::Status receiveWithTimeout(SF::TcpSocket& socket, SF::Packet& packet, SF::Time timeout)
{
    SF::SocketSelector selector;
    selector.add(socket);
    if (selector.wait(timeout))
        return socket.receive(packet);
    else
        return SF::Socket::NotReady;
}
```

## Non-blocking sockets

All sockets are blocking by default, but you can change this behaviour at any time with the `setBlocking` method. 

```
SF::TcpSocket tcpSocket;
tcpSocket.setBlocking(false);

SF::TcpListener listenerSocket;
listenerSocket.setBlocking(false);

SF::UdpSocket udpSocket;
udpSocket.setBlocking(false);
```

Once a socket is set as non-blocking, all of its methods always return immediately. For example, `receive` will return with status `SF::Socket::NotReady` if there's no data available. Or, `accept` will return immediately, with the same status, if there's no pending connection. 

Non-blocking sockets are the easiest solution if you already have a main loop that runs at a constant rate. You can simply check if something happened on your sockets in every iteration, without having to block program execution. 

When using `SF::TcpSocket` in non-blocking mode, calls to `send` are not guaranteed to actually send all the data you pass to it, whether it be as a `SF::Packet` or as raw data. Starting from SFML 2.3, when sending raw data over a non-blocking `SF::TcpSocket`, always make sure to use the `send(const void* data, std::size_t size, std::size_t& sent)` overload which returns the number of bytes actually sent in the `sent` reference parameter after the method returns. Regardless of whether you send `SF::Packet`s or raw data, if only a part of the data was sent in the call, the return status will be `SF::Socket::Partial` to indicate a partial send. *If `SF::Socket::Partial` is returned, you must make sure to handle the partial send properly or else data corruption will occur.* When sending raw data, you must reattempt sending the raw data at the byte offset where the previous `send` call stopped. When sending `SF::Packet`s, the byte offset is saved within the `SF::Packet` itself. In this case, you must make sure to keep attempting to send *the exact same unmodified `SF::Packet` object* over and over until a status other than `SF::Socket::Partial` is returned. Constructing a new `SF::Packet` object and filling it with the same data will not work, it must be the same object that was previously sent. 
