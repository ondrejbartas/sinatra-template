# -*- encoding : utf-8 -*-
ENV['RACK_ENV'] ||= "development"

require 'rack/test'
require 'rake/testtask'
require 'rcov/rcovtask'

Dir["tasks/*.rake"].sort.each { |ext| load ext }

task :default => :test

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/functional/*_test.rb', 'test/unit/*_test.rb','test/integration/*_test.rb']
  t.warning = false
  t.verbose = false
end

namespace :test do
  Rake::TestTask.new(:unit) do |t|
    t.test_files = FileList['test/unit/**/*.rb']
    t.warning = false
    t.verbose = false
  end

  Rake::TestTask.new(:functional) do |t|
    t.test_files = FileList['test/functional/**/*.rb']
    t.warning = false
    t.verbose = false
  end

  Rake::TestTask.new(:integration) do |t|
    t.test_files = FileList['test/integration/**/*.rb']
    t.warning = false
    t.verbose = false
  end
end

desc "Run tests and manage database start/stop"
task :run => [:'redis:start', :'test', :'redis:stop']

desc "Start databases"
task :startup => [:'redis:start']

desc "Teardown databases"
task :teardown => [:'redis:stop']

#get directories!
PIDS_DIR = File.expand_path(File.join("..", "tmp","pid"), __FILE__)
CONF_DIR = File.expand_path(File.join("..", "config"), __FILE__)
#create directory for pid files
FileUtils.mkdir_p(PIDS_DIR) unless File.exists?(PIDS_DIR)
REDIS_PID = File.join(PIDS_DIR, "redis.pid")

#copy example config files for redis if they don't exists
FileUtils.cp(File.join(CONF_DIR, "database_redis.yml.example"), File.join(CONF_DIR, "database_redis.yml") ) unless File.exists?(File.join(CONF_DIR, "redis_config.yml")) 

#for testing purposes use 
REDIS_CNF = File.join(File.expand_path(File.join("..","config"), __FILE__), "redis_test.conf")

desc "Create configs from examples -> do it only if config doesn't exists"
task "prepare:configs" do
  %w{database_redis.yml}.each do |name|
    unless File.exists?(File.join(CONF_DIR, name)) 
      puts "config file: #{File.join(CONF_DIR, "#{name}.example")} -> #{File.join(CONF_DIR, name)}"
      FileUtils.cp(File.join(CONF_DIR, "#{name}.example"), File.join(CONF_DIR, name) ) 
    end
  end
  puts "created config files"
end


namespace :redis do
  desc "Start the Redis server"
  task :start do
    redis_running = \
    begin
      File.exists?(REDIS_PID) && Process.kill(0, File.read(REDIS_PID).to_i)
    rescue Errno::ESRCH
      FileUtils.rm REDIS_PID
      false
    end
    system "pwd"
    system "redis-server #{REDIS_CNF}" unless redis_running
    sleep(5) #fix for waiting to redis start to get pid
    puts "redis started with PID:#{File.read(REDIS_PID).to_i}"
  end

  desc "Stop the Redis server"
  task :stop do
    if File.exists?(REDIS_PID)
      Process.kill "INT", File.read(REDIS_PID).to_i
      puts "redis stopped with PID:#{File.read(REDIS_PID).to_i}"
      FileUtils.rm REDIS_PID
    end
  end
end