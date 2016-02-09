#directory "/opt/Rails" do
#  action :create
#end

#git "/opt/Rails/RailsApp" do
#  repository "https://github.com/bikbajwa/RailsApplication.git"
#end

#execute "update RubyGems" do
#  command <<-EOF
#    gem install ruby-gems-update
#    update_rubygems
#    gem update --system
#  EOF
#end

#gem_package "rails"

#execute "Start the rails server" do
#  command "/opt/Rails/RailsApp/bin/rails server -b 0.0.0.0"
#end

execute "get the information for yum install nodejs" do
  command "curl -sL https://rpm.nodesource.com/setup | bash -"
  action :run
end

package ["gcc", "ruby-devel", "zlib-devel", "rubygems", "sqlite-devel", "nodejs"] do
  action :install
end

gem_package 'bundle'
gem_package 'io-console'
gem_package 'uglifier'

directory "/tmp/RailsApplication/shared/config/" do
  action :create
end

cookbook_file "/tmp/RailsApplication/shared/config/database.yml" do
  source 'database.yml'
  action :create
end

deploy "Rails Application" do
  repo "https://github.com/bikbajwa/RailsApplication.git"
  deploy_to "/tmp/RailsApplication"
  #restart_command "rails s -b 0.0.0.0"
  action :deploy
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
