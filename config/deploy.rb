server '104.236.193.107', roles: [:web, :app, :db], primary: true

set :application, "what2eat"

set :scm, :git
set :repo_url, "https://github.com/guanwill/what2eat.git"
set :branch, 'master'
set :rails_env, 'production'
set :keep_releases, 3
set :user, 'will'

# Deploy config
set :deploy_to, "/var/www/what2eat"
set :use_sudo, false
set :normalize_asset_timestamps, false


set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
set :puma_threads,    [4, 16]
set :puma_workers,    0


namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do

   task :start do ; end
  #  task :stop do ; end
  #  task :restart do
  #    on roles(:app) do
  #     # execute "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  #     invoke 'puma:restart'
  #    end
  #  end

   desc 'Initial Deploy'
   task :initial do
     on roles(:app) do
       before 'deploy:restart', 'puma:start'
       invoke 'deploy'
     end
   end

   desc 'Restart application'
   task :restart do
     on roles(:app), in: :sequence, wait: 5 do
       invoke 'puma:restart'
     end
   end

   after  :finishing,    :compile_assets
   after  :finishing,    :cleanup
   after  :finishing,    :restart

end

# namespace :deploy do
#   desc "Reload the database with seed data"
#   task :seed do
#     on roles(:app) do
#       execute "cd #{current_path}; bundle exec rake db:seed"
#     end
#   end
#
#   desc "Migrate the database"
#   task :migrate do
#     on roles(:app) do
#       execute "cd #{current_path}; bundle exec rake db:migrate"
#     end
#   end
# end
