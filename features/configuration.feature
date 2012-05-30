Feature: the rubycas client allows you to configure it through various methods
  based on need.
  Scenario Outline: Minimal configuration via ruby hash with defaults
    Given A config hash containing:
      | key | value |
      | cas_base_url | http://cas-server.local/cas |
    When I initialize the rubycas client
    Then I expect the configuration for "<key>" to equal "<value>":

    Scenarios: Required Config Parameters
      | key | value |
      | cas_base_url | http://cas-server.local/cas |

    Scenarios: CAS Server Parameters
      | key | value |
      | login_url | http://cas-server.local/cas/login |
      | logout_url | http://cas-server.local/cas/logout |
      | service_validate_url | http://cas-server.local/cas/serviceValidate |
      | proxy_validate_url | http://cas-server.local/cas/proxyValidate |
      | cas_destination_logout_param_name | destination |

    Scenarios: CAS Client Parameters
      | key | value |
      | service_url | |
      | proxy_callback_url | |
      | username_session_key | :cas_user_name |
      | encode_extra_attributes_as | :yaml |
      | proxy_host | |
      | proxy_port | |
