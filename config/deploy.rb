set :application, "hatesitlovesit"
set :repository,  "git@github.com:jjulian/#{application}.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache

role :web, "67.23.5.136"
role :app, "67.23.5.136"
role :db,  "67.23.5.136", :primary => true
set :user, application
set :use_sudo, false
set :deploy_to, "/home/#{application}"
default_run_options[:pty] = true 

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  desc "restart Apache and Passenger"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
