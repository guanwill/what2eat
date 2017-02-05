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

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart do
     on roles(:app) do
      run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
     end
   end
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
