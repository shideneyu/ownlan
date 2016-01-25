module Ownlan
  module Manual
    class Broadcast

      attr_reader :config, :crafted_packet

      def initialize(config)
        @config = config
      end

      def process
        generate_packet

        send_packet
      end

      def generate_packet
        saddr    = config.source_mac
        daddr    = config.victim_mac
        saddr_ip = config.source_ip
        daddr_ip = config.victim_ip


        @crafted_packet = packet_craft(saddr, daddr, saddr_ip, daddr_ip).call
      end

      private

      def packet_craft(*params)
        ServiceObjects::CraftArpPacket.new(*params)
      end

      def send_packet
        ServiceObjects::SendArpPackets.new(config, crafted_packet).call
      end
    end
  end
end
