module ServiceObjects
  class CraftArpPacket
    attr_reader :saddr, :daddr, :saddr_ip, :daddr_ip, :client_ip

    def initialize(config, saddr, daddr, saddr_ip, daddr_ip, client_ip)
      @client_ip = config.client_ip
      @delay     = config.delay
      @interface = config.interface

      @saddr     = saddr
      @daddr     = daddr
      @saddr_ip  = saddr_ip
      @daddr_ip  = daddr_ip

    end

    def call
      arp_packet = PacketFu::ARPPacket.new()

      arp_packet.eth_saddr     = saddr
      arp_packet.eth_daddr     = daddr
      arp_packet.arp_saddr_mac = saddr
      arp_packet.arp_daddr_mac = daddr
      arp_packet.arp_saddr_ip  = saddr_ip
      arp_packet.arp_daddr_ip  = daddr_ip
      arp_packet.arp_opcode    = 1

      arp_packet
    end
  end
end
