module Ownlan
  module Protect
    class Resynchronize < Base

      attr_reader :gateway_packet, :client_packet

      def process
        config.source_mac = gateway_mac
        @gateway_packet = Ownlan::Attack::Client.new(config).generate_packet

        config.source_mac = client_mac
        @client_packet = Ownlan::Attack::Gateway.new(config).generate_packet

        send
      end

      def send
        ServiceObjects::SendArpPackets.new(config, [gateway_packet, client_packet]).call
      end


      def gateway_mac
        gateway_ip = ServiceObjects::NetworkInformation.gateway_ip
        mac        = ::Ownlan::Attack::Base.new(config).ip_to_mac(gateway_ip)
      end

      def client_mac
        ::Ownlan::Attack::Base.new(config).ip_to_mac(config.target_ip)
      end
    end
  end
end