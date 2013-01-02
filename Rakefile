require File.expand_path("lib/i18n_export/version", File.dirname(__FILE__))
require 'rake/testtask'

desc 'Test the i18n-export gem.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/test_*.rb'
  t.verbose = true
end

desc 'Default: run unit tests.'
task :default => :test


