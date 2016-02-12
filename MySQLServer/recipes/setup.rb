mysql_service 'railSQL' do
  port '3306'
  initial_root_password 'railspassword'
  action [:create, :start]
end
