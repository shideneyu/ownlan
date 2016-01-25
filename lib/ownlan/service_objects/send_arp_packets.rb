module ServiceObjects
  class SendArpPackets
      attr_reader :config, :packets

      def initialize(config, packets)
        @config  = config
        @packets = [packets].flatten
      end

      def call
        @i = 0

        loop do
          packets.each do |packet|
            @i += 1
            packet.to_w(config.interface)

            print "\r The ARP packet has been sent successfully #{@i} times"

            sleep config.delay
          end
        end
      end

  end
end
