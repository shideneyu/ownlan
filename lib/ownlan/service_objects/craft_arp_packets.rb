module ServiceObjects
  class CraftArpPacket

    attr_reader :packet

    def initialize(saddr, daddr, saddr_ip, daddr_ip, opcode = 2)
      arp_packet = ::PacketFu::ARPPacket.new

      arp_packet.eth_saddr     = saddr
      arp_packet.eth_daddr     = daddr
      arp_packet.arp_saddr_mac = saddr
      arp_packet.arp_daddr_mac = daddr
      arp_packet.arp_saddr_ip  = saddr_ip
      arp_packet.arp_daddr_ip  = daddr_ip
      arp_packet.arp_opcode    = opcode

      @packet = arp_packet
    end

    def call
      packet
    end
  end
end
