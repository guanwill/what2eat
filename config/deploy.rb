require 'rvm/capistrano'
require 'bundler/capistrano'
require 'delayed/recipes'

set :application, "what2eat"

set :scm, :git
set :repository, "git@bitbucket.org:astadev/ssr.git"
set :git_enable_submodules, 1 # If you have vendored rails
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :rails_env, 'production'

set :user, 'ssr'
set :domain, '54.252.90.81'
set :applicationdir, "/var/www/ssr"

# Server roles
role :web, domain
role :app, domain
role :db, domain

# Deploy config
set :deploy_to, applicationdir
set :deploy_via, :export
set :use_sudo, false
set :normalize_asset_timestamps, false

# Whenever
set :whenever_command, "bundle exec whenever"
require 'whenever/capistrano'

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
