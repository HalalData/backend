# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'HalalData'
set :repo_url, 'git@bitbucket.org:travelin7/openmuslimdata.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/asepco/public_html/halaldata'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :stage, 'production'
set :shared_children, shared_children << 'tmp/sockets'
 
puma_sock    = "unix://#{shared_path}/sockets/puma.sock"
puma_control = "unix://#{shared_path}/sockets/pumactl.sock"
puma_state   = "#{shared_path}/sockets/puma.state"
puma_log     = "#{shared_path}/log/puma-#{stage}.log"

namespace :deploy do

  desc "Start the application"
  task :start do
    run "cd #{current_path} && RAILS_ENV=#{stage} && bundle exec puma -b '#{puma_sock}' -e #{stage} -t2:4 --control '#{puma_control}' -S #{puma_state} >> #{puma_log} 2>&1 &", :pty => false
  end
 
  desc "Stop the application"
  task :stop do
    run "cd #{current_path} && RAILS_ENV=#{stage} && bundle exec pumactl -S #{puma_state} stop"
  end
 
  desc "Restart the application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} && bundle exec pumactl -S #{puma_state} restart"
  end
 
  desc "Status of the application"
  task :status, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} && bundle exec pumactl -S #{puma_state} stats"
  end
  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
