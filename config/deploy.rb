require 'rvm/capistrano'
require 'bundler/capistrano'

set :rvm_type, :user

set :application, "ourscal"
set :repository,  "git@github.com:lancetw/ourscal.git"

ssh_options[:keys] = [
        File.join(ENV["HOME"], ".ssh", "id_rsa"),
        File.join(ENV["HOME"], ".ssh", "github_rsa")
    ]

ssh_options[:forward_agent] = true
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "deliverwork.com"                          # Your HTTP server, Apache/etc
role :app, "deliverwork.com"                          # This may be the same as your `Web` server
role :db,  "deliverwork.com", :primary => true # This is where Rails migrations will run
role :db,  "deliverwork.com"

set :user, "ourscal"
set :deploy_to, "/home/ourscal"
set :deploy_via, :remote_cache
set :use_sudo, false
set :deploy_env, "production"
set :rails_env, "production"
set :scm, :git
set :branch, "master"
set :scm_verbose, true

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do

  task :copy_config_files, :roles => [:app] do
    db_config = "#{shared_path}/database.yml"
    run "cp #{db_config} #{release_path}/config/database.yml"
  end

  task :update_symlink do
    run "ln -s #{shared_path}/public/system #{current_path}/public/system"
  end

  task :run_migrations, :roles => :db do
    puts "RUNNING DB MIGRATIONS"
    run "cd #{current_path}; rake db:migrate RAILS_ENV=#{rails_env}"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "bundle:install", "deploy:copy_config_files"
#after "deploy:finalize_update", "deploy:update_symlink"
