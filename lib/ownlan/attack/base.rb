module Attack
  class Base

    attr_reader :config

    def initialize(application, options)
      config  = application.config
    end

    private

    def self_mac
      @self_mac ||= `ifconfig | grep '#{config.interface}' | tr -s ' ' | cut -d ' ' -f5`
    end

    def gateway_ip
      @gateway_ip ||= `netstat -rn | grep 0.0.0.0 | awk '{print $2}' | grep -v "0.0.0.0"`
    end
  end
end
