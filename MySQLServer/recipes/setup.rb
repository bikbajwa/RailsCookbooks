mysql_service 'railsSQL' do
  port '3306'
  version '5.5'
  initial_root_password 'railspassword'
  action [:create, :start]
end
