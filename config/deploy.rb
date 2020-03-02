# config valid for current version and patch releases of Capistrano
lock "~> 3.12.0"

set :application, "sklife"
set :repo_url, 'https://github.com/nikolaokonesh/sklife.git'

# Deploy to the user's home directory
set :deploy_to, "/home/nikola/#{fetch :application}"

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", '.bundle', "public/system", "public/uploads", "public/sitemaps", "public/packs"

# Only keep the last 5 releases to save disk space
set :keep_releases, 5

# set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# set :sitemap_roles, :web # default

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  # desc "Update crontab with whenever"
  # task :update_cron do
  #   on roles(:app) do
  #     within current_path do
  #       execute :bundle, :exec, "whenever --update-crontab #{fetch(:application)}"
  #     end
  #   end
  # end

  # desc "Generate sitemap"
  # task :sitemap do
  #   on roles(:app) do
  #     within current_path do
  #       execute :bundle, :exec, "rake sitemap:refresh RAILS_ENV=production"
  #     end
  #   end
  # end

  # after :publishing, 'deploy:update_cron'
  # after :publishing, 'deploy:sitemap'
  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
