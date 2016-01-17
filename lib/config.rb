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

    attr_accessor :attack, :protect, :broadcast, :capture, :client, :gateway, :ntoa, :fake_ip_conflict,
                  :stealth, :static, :freeze, :resynchronize, :delay, :interface, :version, :help, :modes

    # Create a new instance.
    #
    # @return [Ownlan::Configuration]
    def initialize
      @modes = { attack: attack_modes, protect: protect_modes, manual: manual_modes }
    end

    private

    def attack_modes
      [:client, :gateway, :ntoa, :fake_ip_conflict]
    end

    def protect_modes
      [:client, :gateway, :ntoa, :fake_ip_conflict]
    end

    def manual_modes
      [:broadcast, :capture]
    end
  end
end