require "./obj"

module SF
  struct IpAddress
    None = IpAddress.new
    Any = IpAddress.new(0u8, 0u8, 0u8, 0u8)
    LocalHost = IpAddress.new(127u8, 0u8, 0u8, 1u8)
    Broadcast = IpAddress.new(255u8, 255u8, 255u8, 255u8)
  end
end
