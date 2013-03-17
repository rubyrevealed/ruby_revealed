require 'rvm/capistrano'
require 'bundler/capistrano'

set :application, 'RubyRevealed'
set :repository,  'git@github.com:rubyrevealed/ruby_revealed.git'

set :scm, :git
set :user, 'server'
set :use_sudo, false

default_run_options[:pty] = true

set :keep_releases, 10
set :deploy_to, "/var/www/apps/rails/\#{application}"

server 'rubyrevealed.com', :app, :web, :db, primary: true

namespace :deploy do
  task :symlink_shared, roles: :app do
    run "ln -s \#{shared_path}/config/database.yml \#{release_path}/config/database.yml"
  end

  task :precompile_assets, roles: :app do
    run "cd \#{release_path} && bundle exec rake assets:precompile RAILS_ENV=production"
  end

  task :restart do
    run "touch \#{current_path}/tmp/restart.txt"
  end
end

after 'deploy:symlink', 'deploy:symlink_shared'
after 'deploy:symlink_shared', 'deploy:precompile_assets'
