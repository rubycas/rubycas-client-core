module RubyCas
  class Client
    class Config
      @@config_defaults = {}
      @@config_required = []
      def self.config_attr(name, default=nil, required=false)
        raise ArgumentError "name #{name} must be a symbol!" unless name.instance_of?(Symbol)
        attr_accessor name
        @@config_defaults[name] = default
        @@config_required << name if required
        private "#{name.to_s}=".to_sym
      end

      #parameters describing the cas server we are talking to
      config_attr :cas_base_url, nil, true
      config_attr :cas_destination_logout_parameter, "destination"
      config_attr :login_url, lambda { |config| "#{config[:cas_base_url]}/login" }
      config_attr :logout_url, lambda { |config| "#{config[:cas_base_url]}/logout" }
      config_attr :service_validate_url, lambda { |config| "#{config[:cas_base_url]}/serviceValidate" }
      config_attr :proxy_validate_url, lambda { |config| "#{config[:cas_base_url]}/proxyValidate" }
      config_attr :cas_destination_logout_param_name, "destination"

      #parameters describing the cas client's configuration
      config_attr :service_url, nil
      config_attr :proxy_callback_url, nil
      config_attr :username_session_key, :cas_user_name
      config_attr :encode_extra_attributes_as, :yaml
      config_attr :proxy_host, nil
      config_attr :proxy_port, nil

      def initialize(conf = nil)
        @@config_required.each do |key|
          raise ArgumentError, "You must specify #{key}" unless conf && conf.has_key?(key)
        end

        full_config = @@config_defaults.merge(conf)
        full_config.each do |k, v|
          value = (v.instance_of?(Proc) ? v.call(full_config) : v)
          send "#{k}=", value
        end
      end
    end
  end
end
