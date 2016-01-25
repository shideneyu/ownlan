module Ownlan
  module Attack
    class Base

      attr_reader :config, :crafted_packet

      def initialize(config)
        @config  = config
      end


      def ip_to_mac(ip = nil)
        if ip == ServiceObjects::NetworkInformation.self_ip(config.interface)
          mac = ServiceObjects::NetworkInformation.self_mac(config.interface)
        else
          mac = ::PacketFu::Utils::arp(ip, iface: config.interface)
          mac ||= raise ::Ownlan::VictimNotReachable, "#{ip}'s mac address cannot be guessed."
        end
      rescue RuntimeError
        raise ::Ownlan::NotRoot, "Please rerun this tool with root privileges."
      rescue ArgumentError
        raise ::Ownlan::WrongVictimIpFormat, "#{ip} is not a valid ip format."
      rescue StandardError
        raise ::Ownlan::WrongInterace, "#{config.interface} is not ready? Retry again"
      end

      private

      def victim_ip
        config.victim_ip ||= raise ::Ownlan::MissingArgumentError, 'victim_ip parameter is missing.'
      end

      def victim_mac
        ip_to_mac(victim_ip)
      end

      def self_mac
        ServiceObjects::NetworkInformation.self_mac(config.interface)
      end

      def packet_craft(*params)
        ServiceObjects::CraftArpPacket.new(*params)
      end

      def send_packet
        ServiceObjects::SendArpPackets.new(config, crafted_packet).call
      end
    end
  end
end
