set :application, "what2eat"

set :scm, :git
set :repository, "https://github.com/guanwill/what2eat.git"
set :branch, 'master'
set :rails_env, 'production'

set :user, 'will'
set :domain, '104.236.193.107'
set :applicationdir, "/home/will/what2eat"

# Server roles
role :web, domain
role :app, domain
role :db, domain

# Deploy config
set :deploy_to, applicationdir
set :use_sudo, false
set :normalize_asset_timestamps, false

# Passenger
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end

namespace :deploy do
  desc "Reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end

  desc "Migrate the database"
  task :migrate do
    run "cd #{current_path}; bundle exec rake db:migrate RAILS_ENV=#{rails_env}"
  end
end
