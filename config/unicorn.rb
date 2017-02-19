# set path to application
app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared "
working_directory app_dir


# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Set up socket location
listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64

# Logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/unicorn.pid"


# # Garbage collection settings.
# GC.respond_to?(:copy_on_write_friendly=) &&
#   GC.copy_on_write_friendly = true
#
# # If using ActiveRecord, disconnect (from the database) before forking.
# before_fork do |server, worker|
#   defined?(ActiveRecord::Base) &&
#     ActiveRecord::Base.connection.disconnect!
# end
#
# # After forking, restore your ActiveRecord connection.
# after_fork do |server, worker|
#   defined?(ActiveRecord::Base) &&
#     ActiveRecord::Base.establish_connection
# end
