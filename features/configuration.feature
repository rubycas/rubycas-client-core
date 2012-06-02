Feature:

  The rubycas client allows you to configure it through various methods
  based on need.

  You can configure it using either a configuration hash with symbols
  as keys or give it a path to a yaml file containing the configuration.

  You can also pass an optional environment key in order to pick which group
  of environment settings you want from the file.

  Scenario Outline: Minimal configuration via ruby hash with defaults
    Given I initialize RubyCas::Client with a config hash containing:
      | key | value |
      | cas_base_url | https://cas-server.local/cas |
    Then I expect the configuration for "<key>" to equal "<value>"

    Scenarios: Required Config Parameters
      | key | value |
      | cas_base_url | https://cas-server.local/cas |

    Scenarios: CAS Server Parameters
      | key | value |
      | login_url | https://cas-server.local/cas/login |
      | logout_url | https://cas-server.local/cas/logout |
      | service_validate_url | https://cas-server.local/cas/serviceValidate |
      | proxy_validate_url | https://cas-server.local/cas/proxyValidate |
      | cas_destination_logout_param_name | destination |

    Scenarios: CAS Client Parameters
      | key | value |
      | service_url | |
      | proxy_callback_url | |
      | username_session_key | :cas_user_name |
      | encode_extra_attributes_as | :yaml |
      | proxy_host | |
      | proxy_port | |

  Scenario: Configuration with a yaml file
    Given a file named "minimal_config.yml" with:
    """
    ---
    cas_base_url: https://cas-server.local/cas
    """

    When I initialize RubyCas::Client with file "minimal_config.yml"

    Then I expect the configuration for "cas_base_url" to equal "https://cas-server.local/cas"

  Scenario: Configuration with a yaml file with different environments
    Given a file named "minimal_config.yml" with:
    """
    ---
    development:
      cas_base_url: https://cas-server.local/cas
    production:
      cas_base_url: https://cas-server.prod/cas
    """

    When I initialize RubyCas::Client with file "minimal_config.yml" and environment "production"

    Then I expect the configuration for "cas_base_url" to equal "https://cas-server.prod/cas"
