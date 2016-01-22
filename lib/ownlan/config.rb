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
                  :freeze, :resynchronize, :delay, :interface, :version, :help, :victim_ip, :random_mac, :source_mac, :modes

    # Create a new instance.
    #
    # @return [Ownlan::Configuration]
    def initialize
      @modes      = { attack: attack_sub_modes, protect: protect_sub_modes, manual: manual_sub_modes }
      @interface  = 'wlan0'
      @delay      = 0.5
      @victim_ip  = '192.168.0.1'
    end

    def source_mac
      @source_mac ||= ::ServiceObjects::NetworkInformation.self_mac(interface)
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

    def manual_sub_modes
      [:broadcast, :capture]
    end
  end
end
