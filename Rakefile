require 'rubygems'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec)

Cucumber::Rake::Task.new(:features)

Cucumber::Rake::Task.new(:wip) do |t|
  t.profile = 'wip'
end

task :default => [:spec, :features]

