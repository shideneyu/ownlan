module ServiceObjects
  class SendArpPackets
    attr_reader :config, :packet

    def initialize(config, packet)
      @config = config
      @packet = packet
    end

    def call
      @i = 0

      loop do
        @i += 1
        packet.to_w(config.interface)

        print "\r The ARP packet has been sent successfully #{@i} times"

        sleep config.delay
      end
    end

  end
end
