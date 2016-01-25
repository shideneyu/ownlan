module Ownlan

  # Access point for the gem configurations.
  #
  # @return [Ownlan::Configuration] a configuration instance.
  def self.config
    @config ||= Configuration.new
  end   

  # Configure hook used in the gem initializer. Convinient way to set all the
  # gem configurations.
  #
  # example:
  #   Ownlan.configure do |config|
  #     config.depth = 3
  #   end
  #
  # @return [void]
  def self.configure
    yield config if block_given?
  end

  class Configuration

    attr_accessor :attack, :protect, :broadcast, :capture, :client, :gateway, :ntoa, :fake_ip_conflict, :stealth, :static,
                  :freeze, :resynchronize, :delay, :interface, :version, :help, :victim_ip, :victim_mac, :gateway_ip,
                  :gateway_mac, :source_ip, :source_mac, :random_mac, :modes

    alias :target_ip :victim_ip
    alias :target_ip= :victim_ip=

    alias :target_mac :victim_mac
    alias :target_mac= :victim_mac=

    # Create a new instance.
    #
    # @return [Ownlan::Configuration]
    def initialize
      @modes      = { attack: attack_sub_modes, protect: protect_sub_modes, manual: manual_sub_modes }
      @interface  = 'wlan0'
      @delay      = 0.5
      @random_mac = false
    end

    def source_mac
      @source_mac ||= if self.victim_ip
        ::ServiceObjects::NetworkInformation.self_mac(interface)
      else
        gateway_ip = ServiceObjects::NetworkInformation.gateway_ip
        mac = ::Ownlan::Attack::Base.new(self).ip_to_mac(gateway_ip)
      end
    end

    def manual_sub_modes
      [:broadcast, :capture]
    end

    private

    def main_modes
      [:attack, :protect, :manual]
    end

    def attack_sub_modes
      [:client, :gateway, :ntoa, :fake_ip_conflict]
    end

    def protect_sub_modes
      [:freeze, :resynchronize, :static, :stealth]
    end

  end
end
