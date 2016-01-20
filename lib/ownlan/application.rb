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
      return invalid_arguments if no_valid_argument?

      config.modes.each do |type, modes|
        modes.each { |mode| process(type, mode) }
      end

    end

    private

    def invalid_arguments
      Trollop.educate
    rescue ArgumentError
      raise ::Ownlan::MissingArgumentError
    end

    def set_options(config_options)
      config_options.each { |k, v| config.send("#{k}=", v) }
    end

    def process(type, mode)
      "Ownlan::#{type.capitalize}::#{mode.capitalize}".constantize.new(config).process if raw_options[mode]
    end

    def no_valid_argument?
      !config.instance_variables.find { |opt, _| config.modes.values.flatten.find{|mode| "@#{mode}" == opt.to_s }}
    end
  end
end