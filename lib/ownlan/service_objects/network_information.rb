module ServiceObjects
  class NetworkInformation
    def self.self_mac(interface)
      @self_mac ||= `ifconfig | grep '#{interface}' | tr -s ' ' | cut -d ' ' -f5`.strip
    end

    def self.gateway_ip
      @gateway_ip ||= `netstat -rn | grep 0.0.0.0 | awk '{print $2}' | grep -v "0.0.0.0"`.strip
    end

    def self.self_ip
      @self_ip ||= Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
    end
  end
end
