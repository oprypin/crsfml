# Using packets

## Problems that need to be solved

Exchanging data on a network is more tricky than it seems. The reason is that different machines, with different operating systems and processors, can be involved. Several problems arise if you want to exchange data reliably between these different machines.

The first problem is the endianness. The endianness is the order in which a particular processor interprets the bytes of primitive types that occupy more than a single byte (integers and floating point numbers). There are two main families: "big endian" processors, which store the most significant byte first, and "little endian" processors, which store the least significant byte first. There are other, more exotic byte orders, but you'll probably never have to deal with them.  
The problem is obvious: If you send a variable between two computers whose endianness doesn't match, they won't see the same value. For example, the 16-bit integer "42" in big endian notation is 00000000 00101010, but if you send this to a little endian machine, it will be interpreted as "10752".

The second problem is specific to how the TCP protocol works. Because it doesn't preserve message boundaries, and can split or combine chunks of data, receivers must properly reconstruct incoming messages before interpreting them. Otherwise bad things might happen, like reading incomplete variables, or ignoring useful bytes.

You may of course face other problems with network programming, but these are the lowest-level ones, that almost everybody will have to solve. This is the reason why SFML provides some simple tools to avoid them.

## Packets

The two problems (endianness and message boundaries) are solved by using a specific class to pack your data: [Packet]({{book.api}}/Packet.html). As a bonus, it provides a much nicer interface than plain old byte arrays.

```crystal
# on sending side
x = 10_u16
s = "hello"
d = 0.6_f64

packet = SF::Packet.new()
packet.write(x)
packet.write(s)
packet.write(d)
```

```crystal
# on receiving side
x = packet.read(UInt16)
s = packet.read(String)
d = packet.read(Float64)
pp x, s, d
```

Unlike writing, reading from a packet can fail if you try to extract more bytes than the packet contains. If a reading operation fails, the packet error flag is set. To check the error flag of a packet, use the `valid?` method:

```crystal
x = packet.read(Int32)
unless packet.valid?
  # error
end
```

Sending and receiving packets is as easy as sending/receiving an array of bytes: sockets have `send` and `receive` methods that directly accept a [Packet]({{book.api}}/Packet.html).

```crystal
# with a TCP socket
status = tcp_socket.send(packet)

packet = SF::Packet.new
status = tcp_socket.receive(packet)
```

```crystal
# with a UDP socket
status = udp_socket.send(packet, recipient_address, recipient_port)

packet = SF::Packet.new
status, sender_address, sender_port = udp_socket.receive(packet)
```

Packets solve the "message boundaries" problem, which means that when you send a packet on a TCP socket, you receive the exact same packet on the other end, it cannot contain less bytes, or bytes from the next packet that you send. However, it has a slight drawback: To preserve message boundaries, [Packet]({{book.api}}/Packet.html) has to send some extra bytes along with your data, which implies that you can only receive them with a [Packet]({{book.api}}/Packet.html) if you want them to be properly decoded. Simply put, you can't send an SFML packet to a non-SFML packet recipient, it has to use an SFML packet for receiving too. Note that this applies to TCP only, UDP is fine since the protocol itself preserves message boundaries.

## Extending packets to handle user types

Packets have overloads of their methods for the most common primitive types and the most common standard types, but what about your own classes? It is easy to subclass or reopen [Packet]({{book.api}}/Packet.html) and add your own overloads.

```crystal
record Character, age : UInt8, name : String, weight : Float32

class SF::Packet
  def write(c : Character)
    write c.age
    write c.name
    write c.weight
  end

  def read(type : Character.class) : Character
    Character.new(read(UInt8), read(String), read(Float32))
  end
end
```

Now that these methods are defined, you can insert/extract a `Character` instance to/from a packet like any other primitive type:

```crystal
bob = Character.new(65_u8, "Bob", 12.34_f32)

packet.write(bob)
packet.read(Character)
```
