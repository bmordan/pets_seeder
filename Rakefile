require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
task :matrix do
    pid = spawn("cmatrix")
    sleep 3
    Process.kill('QUIT', pid)
    system("clear")
end
