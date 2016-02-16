deploy "Rails Application" do
  repo "https://github.com/bikbajwa/RailsApplication.git"
  deploy_to "/tmp/RailsApplication"
  restart_command "touch tmp/restart.txt"
  action :deploy
end

directory "/tmp/RailsApplication/shared/config/" do
  action :create
end

template "/tmp/RailsApplication/shared/config/database.yml" do
  source 'database.yml.erb'
  variables({
    :database => node[:deploy]['RailsApplication'][:environment_variables][:RDS_DB_NAME],
    :username => node[:deploy]['RailsApplication'][:environment_variables][:RDS_USERNAME],
    :password => node[:deploy]['RailsApplication'][:environment_variables][:RDS_PASSWORD],
    :host => node[:deploy]['RailsApplication'][:environment_variables][:RDS_HOSTNAME],
    :port => node[:deploy]['RailsApplication'][:environment_variables][:RDS_PORT]
    })
  action :create
end

# bundle isn't working
execute "run bundle" do
  cwd "/tmp/RailsApplication/current/"
  command <<-EOF
    . /etc/profile.d/ruby.sh
    bundle
  EOF
  action :run
end

execute "Remove the pids file and start the rails application" do
  cwd "/tmp/RailsApplication/current/"
  command <<-EOF
    . /etc/profile.d/ruby.sh
    rm -rf tmp/pids
    rails s -b 0.0.0.0 -d
  EOF
  action :run
end
