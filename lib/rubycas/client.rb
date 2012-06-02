require 'rubycas/client/config'

module RubyCas
  class Client
    attr_reader :config
    def initialize(conf, environment=nil)

      conf_hash = case conf
      when Hash
        conf
      when String
        parse_config_file(conf)
      else
        raise ArgumentError, "Could not configure RubyCas::Client with #{conf.inspect}"
      end
      conf_hash = stringify_hash_keys(conf_hash)

      unless environment.nil?
        conf_hash = stringify_hash_keys(conf_hash[environment.to_sym])
      end

      @config = Config.new(conf_hash)
      @config.freeze
    end

    private
    def parse_config_file(file_path)
      YAML::load(File.read(file_path))
    end

    def stringify_hash_keys(hash)
      hash.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end
  end
end
