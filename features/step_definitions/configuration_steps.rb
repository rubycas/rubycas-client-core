def normalize_config_value(value)
  case value
  when "" then nil
  when /^:(.+)$/ then $1.to_sym
  else value
  end
end

def table_to_config_hash(table)
  config = {}
  table.map_column!('key') do |k|
    k.to_sym
  end
  table.map_column!('value') do |v|
    normalize_config_value(v)
  end
  table.hashes.each do |h|
    config[h[:key]] = h[:value]
  end
  config
end

Given /^I initialize RubyCas::Client with a config hash containing:$/ do |table|
  config = table_to_config_hash(table)
  @client = RubyCas::Client.new(config)
end

When /^I initialize RubyCas::Client with file "([\S]*?)"$/ do |file_path|
  in_current_dir do
    @client = RubyCas::Client.new(file_path)
  end
end

When /^I initialize RubyCas::Client with file "([\S]*?)" and environment "([\S]*?)"$/ do |file_path, environment|
  in_current_dir do
    @client = RubyCas::Client.new(file_path, environment)
  end
end

Then /^I expect the configuration for "(.*?)" to equal "(.*?)"$/ do |key, value|
  @client.config.send(key.to_sym).should == normalize_config_value(value)
end
