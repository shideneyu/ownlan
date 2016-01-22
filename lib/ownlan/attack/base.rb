module Ownlan
  module Attack
    class Base

      attr_reader :config

      def initialize(config)
        @config  = config
      end

      private

      def victim_ip
        config.victim_ip ||= raise ::Ownlan::MissingArgumentError, 'victim_ip parameter is missing.'
      end

      def victim_mac
        ip_to_mac(victim_ip)
      end

      def ip_to_mac(ip = nil)
        mac = ::PacketFu::Utils::arp(ip, iface: config.interface)
        mac ||= raise ::Ownlan::VictimNotReachable, "#{ip}'s mac address cannot be guessed."
      rescue RuntimeError
        raise ::Ownlan::NotRoot, "Please rerun this tool with root privileges."
      rescue ArgumentError
        raise ::Ownlan::WrongVictimIpFormat, "#{ip} is not a valid ip format."
      rescue StandardError
        raise ::Ownlan::WrongInterace, "#{config.interface} is not ready? Retry again"
      end

      def self_mac
        ServiceObjects::NetworkInformation.self_mac(config.interface)
      end

      def packet_craft(*params)
        ServiceObjects::CraftArpPacket.new(*params)
      end

      def send_packet(*params)
        ServiceObjects::SendArpPackets.new(*params).call
      end
    end
  end
end
