# Using packets

## Problems that need to be solved

Exchanging data on a network is more tricky than it seems. The reason is that different machines, with different operating systems and processors, can be involved. Several problems arise if you want to exchange data reliably between these different machines.

The first problem is the endianness. The endianness is the order in which a particular processor interprets the bytes of primitive types that occupy more than a single byte (integers and floating point numbers). There are two main families: "big endian" processors, which store the most significant byte first, and "little endian" processors, which store the least significant byte first. There are other, more exotic byte orders, but you'll probably never have to deal with them.  
The problem is obvious: If you send a variable between two computers whose endianness doesn't match, they won't see the same value. For example, the 16-bit integer "42" in big endian notation is 00000000 00101010, but if you send this to a little endian machine, it will be interpreted as "10752".

The second problem is specific to how the TCP protocol works. Because it doesn't preserve message boundaries, and can split or combine chunks of data, receivers must properly reconstruct incoming messages before interpreting them. Otherwise bad things might happen, like reading incomplete variables, or ignoring useful bytes.

You may of course face other problems with network programming, but these are the lowest-level ones, that almost everybody will have to solve. This is the reason why SFML provides some simple tools to avoid them.

## Packets

The two problems (endianness and message boundaries) are solved by using a specific class to pack your data: [Packet]({{book.api}}/Packet.html). As a bonus, it provides a much nicer interface than plain old byte arrays.

Packets have a programming interface similar to standard streams: you can insert data with the &lt;&lt; operator, and extract data with the &gt;&gt; operator.

```ruby
# on sending side
x = 10u16
s = "hello"
d = 0.6

packet = SF::Packet.new()
packet.write_uint16(x)
packet.write_string(s)
packet.write_double(d)
```

```ruby
# on receiving side
x = packet.read_uint16()
s = packet.read_string()
d = packet.read_double()
```

Unlike writing, reading from a packet can fail if you try to extract more bytes than the packet contains. If a reading operation fails, the packet error flag is set. To check the error flag of a packet, use the `can_read` method:

```ruby
x = packet.read_int32()
unless packet.can_read
  # error
end
```

Sending and receiving packets is as easy as sending/receiving an array of bytes: sockets have `send_packet` and `receive_packet` methods that directly accept a [Packet]({{book.api}}/Packet.html).

```ruby
# with a TCP socket
tcp_socket.send_packet(packet)
packet = tcp_socket.receive_packet()
```

```ruby
# with a UDP socket
udp_socket.send_packet(packet, recipient_address, recipient_port)
packet, sender_address, sender_port = udp_socket.receive_packet()
```

Packets solve the "message boundaries" problem, which means that when you send a packet on a TCP socket, you receive the exact same packet on the other end, it cannot contain less bytes, or bytes from the next packet that you send. However, it has a slight drawback: To preserve message boundaries, [Packet]({{book.api}}/Packet.html) has to send some extra bytes along with your data, which implies that you can only receive them with a [Packet]({{book.api}}/Packet.html) if you want them to be properly decoded. Simply put, you can't send an SFML packet to a non-SFML packet recipient, it has to use an SFML packet for receiving too. Note that this applies to TCP only, UDP is fine since the protocol itself preserves message boundaries.

<!--

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

-->