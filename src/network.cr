# Copyright (C) 2015 Oleh Prypin <blaxpirit@gmail.com>
#
# This file is part of CrSFML.
#
# This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgement in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.

require "./lib/csfml/network"
require "./system"

module SF
  extend self

  class Ftp
    def connect(server: IpAddress, port=21: Int)
      connect(server, port, Time::Zero)
    end
    def login()
      login_anonymous()
    end

    def get_directory_listing()
      get_directory_listing("")
    end
  end

  def ip_address()
    ip_address(0u8, 0u8, 0u8, 0u8)
  end
  struct CSFML::IpAddress
    None = SF.ip_address()
    LocalHost = SF.ip_address(127u8, 0u8, 0u8, 1u8)
    Broadcast = SF.ip_address(255u8, 255u8, 255u8, 255u8)

    def to_s
      #buffer = Slice(UInt8).new(16)
      #CSFML.ip_address_to_string(self, buffer)
      #String.new(buffer.to_unsafe)
      String.new(self.address.to_unsafe)
    end
  end

  class Http
    def initialize(host: String, port=0)
      initialize()
      set_host(host, port)
    end
    def set_host(host: String)
      set_host(host, 0)
    end

    def send_request(request: SF::HttpRequest)
      send_request(request, SF.milliseconds(0))
    end
  end

  class HttpRequest
    def initialize(uri: String, method=HttpRequest::Get, body="")
      initialize()
      self.uri = uri
      self.method = method
      self.body = body
    end
  end

  class Packet
    def read_string()
      size = dup.read_uint32
      return "" unless size > 0
      String.new(size) do |buffer|
        CSFML.packet_read_string(@this, buffer)
        {size, 0}
      end
    end

    def write_string(string: String)
      CSFML.packet_write_string(@this, string)
    end
  end

  class SocketSelector
    def wait()
      wait(SF::Time::Zero)
    end
  end

  class TcpSocket
    def connect(host: IpAddress, port: Int)
      connect(host, port, SF::Time::Zero)
    end

    def send_partial(data: Void*, size: Int): {SocketStatus, Int}
      r = CSFML.tcp_socket_send_partial(@this, data, LibC::SizeT.cast(size), out sent)
      {r, sent}
    end

    def receive(data: Void*, max_size: Int): {SocketStatus, Int}
      r = CSFML.tcp_socket_receive(@this, data, LibC::SizeT.cast(max_size), out size_received)
      {r, size_received}
    end
  end

  class TcpListener
    def accept(): {SocketStatus, TcpSocket}
      r = CSFML.tcp_listener_accept(@this, out connected)
      {r, connected}
    end
  end

  class UdpSocket
    def receive(data: Void*, max_size: Int, size_received: SizeT*, address: IpAddress*, port: UInt16*): {SocketStatus, Int, IpAddress, UInt16}
      r = CSFML.udp_socket_receive(@this, data, LibC::SizeT.cast(max_size), out size_received, out address, out port)
      {r, size_received, address, port}
    end
  end
end

require "./network_obj"
