threads 8,32
workers 3

environment 'production'
daemonize true
pidfile '/home/deploy/apps/inframe/shared/tmp/pids/puma.pid'
state_path '/home/deploy/apps/inframe/shared/tmp/pids/puma.state'

stdout_redirect '/home/deploy/apps/inframe/shared/log/puma.log', '/home/deploy/apps/inframe/shared/log/puma.err', true

bind 'tcp://127.0.0.1:9292'

preload_app!
