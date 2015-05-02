server '104.236.75.32', user: 'deploy', roles: %w{web app db}

set :ssh_options, { forward_agent: true, auth_methods: ['publickey'] }
