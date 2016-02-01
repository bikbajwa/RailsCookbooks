git "#{Chef::Config[:file_cache_path]}/RailsApp" do
  repository "https://github.com/bikbajwa/RailsApplication.git"
end

gem "rails"

execute "Start the rails server" do
  command "#{Chef::Config[:file_cache_path]}/RailsApp/bin/rails server -b 0.0.0.0"
end
