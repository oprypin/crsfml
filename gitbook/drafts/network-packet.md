# Using and extending packets

## Problems that need to be solved

Exchanging data on a network is more tricky than it seems. The reason is that different machines, with different operating systems and processors, can be involved. Several problems arise if you want to exchange data reliably between these different machines.

The first problem is the endianness. The endianness is the order in which a particular processor interprets the bytes of primitive types that occupy more than a single byte (integers and floating point numbers). There are two main families: "big endian" processors, which store the most significant byte first, and "little endian" processors, which store the least significant byte first. There are other, more exotic byte orders, but you'll probably never have to deal with them.
The problem is obvious: If you send a variable between two computers whose endianness doesn't match, they won't see the same value. For example, the 16-bit integer "42" in big endian notation is 00000000 00101010, but if you send this to a little endian machine, it will be interpreted as "10752".

The second problem is the size of primitive types. The C++ standard doesn't set the size of primitive types (char, short, int, long, float, double), so, again, there can be differences between processors -- and there are. For example, the `long int` type can be a 32-bit type on some platforms, and a 64-bit type on others.

The third problem is specific to how the TCP protocol works. Because it doesn't preserve message boundaries, and can split or combine chunks of data, receivers must properly reconstruct incoming messages before interpreting them. Otherwise bad things might happen, like reading incomplete variables, or ignoring useful bytes.

You may of course face other problems with network programming, but these are the lowest-level ones, that almost everybody will have to solve. This is the reason why SFML provides some simple tools to avoid them.

## Fixed-size primitive types

Since primitive types cannot be exchanged reliably on a network, the solution is simple: don't use them. SFML provides fixed-size types for data exchange: `SF::Int8, SF::Uint16, SF::Int32`, etc. These types are just typedefs to primitive types, but they are mapped to the type which has the expected size according to the platform. So they can (and must!) be used safely when you want to exchange data between two computers.

SFML only provides fixed-size *integer* types. Floating-point types should normally have their fixed-size equivalent too, but in practice this is not needed (at least on platforms where SFML runs), `float` and `double` types always have the same size, 32 bits and 64 bits respectively.

## Packets

The two other problems (endianness and message boundaries) are solved by using a specific class to pack your data: [Packet]({{book.api}}/Packet.html). As a bonus, it provides a much nicer interface than plain old byte arrays.

Packets have a programming interface similar to standard streams: you can insert data with the &lt;&lt; operator, and extract data with the &gt;&gt; operator.

```
// on sending side
SF::Uint16 x = 10;
std::string s = "hello";
double d = 0.6;

SF::Packet packet;
packet << x << s << d;
```



```
// on receiving side
SF::Uint16 x;
std::string s;
double d;

packet >> x >> s >> d;
```

Unlike writing, reading from a packet can fail if you try to extract more bytes than the packet contains. If a reading operation fails, the packet error flag is set. To check the error flag of a packet, you can test it like a boolean (the same way you do with standard streams):

```
if (packet >> x)
{
    // ok
}
else
{
    // error, failed to read 'x' from the packet
}
```

Sending and receiving packets is as easy as sending/receiving an array of bytes: sockets have an overload of `send` and `receive` that directly accept a [Packet]({{book.api}}/Packet.html).

```
// with a TCP socket
tcpSocket.send(packet);
tcpSocket.receive(packet);
```



```
// with a UDP socket
udpSocket.send(packet, recipientAddress, recipientPort);
udpSocket.receive(packet, senderAddress, senderPort);
```

Packets solve the "message boundaries" problem, which means that when you send a packet on a TCP socket, you receive the exact same packet on the other end, it cannot contain less bytes, or bytes from the next packet that you send. However, it has a slight drawback: To preserve message boundaries, [Packet]({{book.api}}/Packet.html) has to send some extra bytes along with your data, which implies that you can only receive them with a [Packet]({{book.api}}/Packet.html) if you want them to be properly decoded. Simply put, you can't send an SFML packet to a non-SFML packet recipient, it has to use an SFML packet for receiving too. Note that this applies to TCP only, UDP is fine since the protocol itself preserves message boundaries.

## Extending packets to handle user types

Packets have overloads of their operators for all the primitive types and the most common standard types, but what about your own classes? As with standard streams, you can make a type "compatible" with [Packet]({{book.api}}/Packet.html) by providing an overload of the &lt;&lt; and &gt;&gt; operators.

```
struct Character
{
    SF::Uint8 age;
    std::string name;
    float weight;
};

SF::Packet& operator <<(SF::Packet& packet, const Character& character)
{
    return packet << character.age << character.name << character.weight;
}

SF::Packet& operator >>(SF::Packet& packet, Character& character)
{
    return packet >> character.age >> character.name >> character.weight;
}
```

Both operators return a reference to the packet: This allows chaining insertion and extraction of data.

Now that these operators are defined, you can insert/extract a `Character` instance to/from a packet like any other primitive type:

```
Character bob;

packet << bob;
packet >> bob;
```

## Custom packets

Packets provide nice features on top of your raw data, but what if you want to add your own features such as automatically compressing or encrypting the data? This can easily be done by deriving from [Packet]({{book.api}}/Packet.html) and overriding the following methods:

  * `onSend`: called before the data is sent by the socket
  * `onReceive`: called after the data has been received by the socket

These methods provide direct access to the data, so that you can transform them according to your needs.

Here is a mock-up of a packet that performs automatic compression/decompression:

```
class ZipPacket : public SF::Packet
{
    virtual const void* onSend(std::size_t& size)
    {
        const void* srcData = getData();
        std::size_t srcSize = getDataSize();
        return compressTheData(srcData, srcSize, &size); // this is a fake function, of course :)
    }
    virtual void onReceive(const void* data, std::size_t size)
    {
        std::size_t dstSize;
        const void* dstData = uncompressTheData(data, size, &dstSize); // this is a fake function, of course :)
        append(dstData, dstSize);
    }
};
```

Such a packet class can be used exactly like [Packet]({{book.api}}/Packet.html). All your operator overloads will apply to them as well.

```
ZipPacket packet;
packet << x << bob;
socket.send(packet);
```

