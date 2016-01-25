module Ownlan
  module Attack
    class Client < Base

      def process
        generate_packet

        send_packet
      end

      def generate_packet(target_ip = nil)
        gw_ip    = ServiceObjects::NetworkInformation.gateway_ip

        saddr    = config.source_mac
        daddr    = config.victim_mac || victim_mac
        saddr_ip = gw_ip
        daddr_ip = victim_ip


        @crafted_packet = packet_craft(saddr, daddr, saddr_ip, daddr_ip).call
      end
    end
  end
end
