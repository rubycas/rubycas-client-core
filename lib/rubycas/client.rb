require 'rubycas/client/config'

module RubyCas
  class Client
    attr_reader :config
    def initialize(conf)
      @config = Config.new(conf)
      @config.freeze
    end
  end
end
