module Ownlan
  class Application

    attr_reader :raw_options, :config

    def initialize(options)
      @raw_options = options

      @config = ::Ownlan.config.dup

      config_options = raw_options.reject{ |k, v| k.to_s.match('_given') || !v }
      set_options(config_options)
    end

    def call
      action = config.modes.find do |type, modes|
        modes.find { |mode| process(type, mode) }
      end

      show_menu unless action
    end

    private

    def show_menu
      Trollop.educate
    rescue ArgumentError
      raise ::Ownlan::MissingArgumentError, 'Missing or Invalid parameter.'
    end

    def set_options(config_options)
      config_options.each { |k, v| config.send("#{k}=", v) }
    end

    def process(type, mode)
      return unless good_args?(type, mode)
      "Ownlan::#{type.capitalize}::#{mode.capitalize}".constantize.new(config).process
    rescue ::NoMethodError
      show_menu
    end

    def good_args?(type, mode)
      raw_options[type] == mode.to_s
    end

  end
end