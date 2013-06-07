set :application, "penezotron"
set :repository,  "git://github.com/MichalPokorny/penezotron.git"
set :user, "rails"

set :scm, :git

set :deploy_to, "/srv/rails/penezotron"

role :web, "rny.cz"                          # Your HTTP server, Apache/etc
role :app, "rny.cz"                          # This may be the same as your `Web` server
role :db,  "rny.cz", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
	task :bundle, :role => :app, :except => { :no_release => true } do
		run "cd #{current_path} && bundle install --without=test --deployment"
	end
end

namespace :custom do
	task :symlink, roles: :app do
		run <<-CMD
			rm #{release_path}/config/database.yml;
			rm -rf #{release_path}/vendor/bundle;
			ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml;
			ln -nfs #{shared_path}/bundle #{release_path}/vendor/bundle;
		CMD
	end
end

after "deploy:create_symlink", "custom:symlink", "deploy:bundle"
