module ServiceObjects
  class SendArpPackets
    attr_reader :arp_packet, :config

    def initialize(application, packet)
      @packet = packet
      @config = application.config
    end

    def call
      @i = 0

      Thread.new do
        while true
          print "\r The ARP packet has been sent successfully #{@i} times"
        end
      end

      while true
        @i += 1
        packet.to_w(config.interface)
        sleep config.delay
      end
    end

  end
end
