require 'rake/testtask'
require "bundler/gem_tasks"

task :default => [:run_tests]
Rake::TestTask.new("run_tests") do |t|
  t.pattern = 'test/test_*.rb'
  t.verbose = true
end