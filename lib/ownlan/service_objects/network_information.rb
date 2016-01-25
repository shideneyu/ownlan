module ServiceObjects
  class NetworkInformation
    def self.self_mac(interface)
      @self_mac ||= `ifconfig "#{interface}" | head -n1 | tr -s ' ' | cut -d' ' -f5`.strip
    end

    def self.gateway_ip
      @gateway_ip ||= `netstat -rn | grep 0.0.0.0 | awk '{print $2}' | grep -v "0.0.0.0"`.strip
    end

    def self.self_ip(interface)
      @self_ip ||= `ip addr ls "#{interface}" | awk '/inet / {print $2}' | cut -d"/" -f1`.strip
    end
  end
end
