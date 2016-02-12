deploy "Rails Application" do
  repo "https://github.com/bikbajwa/RailsApplication.git"
  deploy_to "/tmp/RailsApplication"
  restart_command "touch tmp/restart.txt"
  action :deploy
end

directory "/tmp/RailsApplication/shared/config/" do
  action :create
end

cookbook_file "/tmp/RailsApplication/shared/config/database.yml" do
  source 'database.yml'
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
