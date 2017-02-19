# set path to application
# app_dir = File.expand_path("../..", __FILE__)
# shared_dir = "#{app_dir}/shared"
working_dir = '/var/www/what2eat/current'
working_directory working_dir


# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Set up socket location
listen "#{working_dir}/tmp/sockets/unicorn.sock", :backlog => 64

# Logging
stderr_path "#{working_dir}/log/unicorn.stderr.log"
stdout_path "#{working_dir}/log/unicorn.stdout.log"

# Set master PID location
pid "#{working_dir}/tmp/pids/unicorn.pid"


# If using ActiveRecord, disconnect (from the database) before forking.
before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

# After forking, restore your ActiveRecord connection.
after_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end


# before_fork do |server, worker|
#   Signal.trap 'TERM' do
#     puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
#     Process.kill 'QUIT', Process.pid
#   end
#
#   if defined? ActiveRecord::Base
#     ActiveRecord::Base.connection.disconnect!
#   end
# end
#
# after_fork do |server, worker|
#   Signal.trap 'TERM' do
#     puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
#   end
#
#   if defined? ActiveRecord::Base
#     ActiveRecord::Base.establish_connection
#   end
# end
