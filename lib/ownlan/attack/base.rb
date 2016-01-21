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
        mac = ::PacketFu::Utils::arp(victim_ip, iface: config.interface)
        mac ||= raise ::Ownlan::VictimNotReachable, "#{victim_ip}'s mac address cannot be guessed."
      rescue ArgumentError
        raise ::Ownlan::WrongVictimIpFormat, "#{victim_ip} is not a valid ip format."
      end

      def self_mac
        ServiceObjects::NetworkInformation.self_mac(config.interface)
      end
    end
  end
end
