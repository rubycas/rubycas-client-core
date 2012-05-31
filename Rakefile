#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake'
require 'appraisal'
require 'yard'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

desc 'Default: run the specs and features.'
task :default do
  system("bundle exec rake -s appraisal spec features;")
end

RSpec::Core::RakeTask.new

Cucumber::Rake::Task.new do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end

YARD::Rake::YardocTask.new

desc 'run all the specs and features'
task :default => ['spec', 'cucumber']
