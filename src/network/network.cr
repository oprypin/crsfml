require "./obj"

module SF
  struct IpAddress
    # Value representing an empty/invalid address
    None = new
    # Value representing any address (0.0.0.0)
    Any = new(0, 0, 0, 0)
    # The "localhost" address (for connecting a computer to itself locally)
    LocalHost = new(127, 0, 0, 1)
    # The "broadcast" address (for sending UDP messages to everyone on a local network)
    Broadcast = new(255, 255, 255, 255)

    def inspect(io)
      io << {{@type.name}} << "(\"" << to_s << "\")"
    end
  end
end
