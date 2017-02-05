server '104.236.193.107', roles: [:web, :app, :db], primary: true


set :application, "what2eat"

set :scm, :git
set :repo_url, "https://github.com/guanwill/what2eat.git"
set :branch, 'master'
set :rails_env, 'production'
set :keep_releases, 5
set :user, 'will'

# Deploy config
set :deploy_to, "/var/www/what2eat"
set :use_sudo, false
set :normalize_asset_timestamps, false

# Passenger
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart do
    #  run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
     on roles(:app), in: :sequence, wait: 5 do
     end
   end
end

namespace :deploy do
  desc "Reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed"
  end

  desc "Migrate the database"
  task :migrate do
    run "cd #{current_path}; bundle exec rake db:migrate"
  end
end
