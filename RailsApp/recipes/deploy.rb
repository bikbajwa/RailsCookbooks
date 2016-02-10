execute "get the information for yum install nodejs" do
  command "curl -sL https://rpm.nodesource.com/setup | bash -"
  action :run
end

package ["gcc", "ruby-devel", "zlib-devel", "rubygems", "sqlite-devel", "nodejs"] do
  action :install
end

gem_package 'bundle'
gem_package 'io-console' # not working
gem_package 'uglifier'

deploy "Rails Application" do
  repo "https://github.com/bikbajwa/RailsApplication.git"
  deploy_to "/tmp/RailsApplication"
  #restart_command "rails s -b 0.0.0.0"
  action :deploy
end

directory "/tmp/RailsApplication/shared/config/" do
  action :create
end

cookbook_file "/tmp/RailsApplication/shared/config/database.yml" do
  source 'database.yml'
  action :create
end

execute "run bundle" do
  cwd "/tmp/RailsApplication/current/"
  command "bundle"
  action :run
end

cookbook_file "/etc/profile.d/ruby.sh" do
  source "ruby.sh"
  action :create
end

execute "Remove the pids file" do
  command "rm -f /tmp/RailsApplication/current/tmp/pids"
  action :execute
end
