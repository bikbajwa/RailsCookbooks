execute "get the information for yum install nodejs" do
  command "curl -sL https://rpm.nodesource.com/setup | bash -"
  action :run
end

package ["gcc", "ruby-devel", "zlib-devel", "rubygems", "sqlite-devel", "nodejs"] do
  action :install
end

gem_package 'bundle'
gem_package 'uglifier'

cookbook_file "/etc/profile.d/ruby.sh" do
  source "ruby.sh"
  action :create
end
