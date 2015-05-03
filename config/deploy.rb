lock '3.3.5'

set :application, 'inframe'
set :repo_url, 'git@github.com:thecoopermen/framesetter.git'
set :deploy_to, '/home/deploy/apps/inframe'
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/aws.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')
