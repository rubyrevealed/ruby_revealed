require 'bundler/capistrano'

set :application, 'RubyRevealed'
set :repository,  'git@github.com:ardavis/ruby_revealed.git'

set :scm, :git
set :user, 'server'
set :use_sudo, false

default_run_options[:pty] = true

set :keep_releases, 10
set :deploy_to, "/var/www/apps/rails/#{application}"

server 'rubyrevealed.com', :app, :web, :db, primary: true