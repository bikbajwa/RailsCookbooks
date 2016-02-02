git "#{Chef::Config[:file_cache_path]}/RailsApp" do
  repository "https://github.com/bikbajwa/RailsApplication.git"
end

execute "update RubyGems" do
  command <<-EOF
    gem install ruby-gems-update
    update_rubygems
    gem update --system
  EOF
end

#gem_package "rails"

execute "Start the rails server" do
  command "#{Chef::Config[:file_cache_path]}/RailsApp/bin/rails server -b 0.0.0.0"
end
