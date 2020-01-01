

java-1.8.0-openjdk-devel.x86_64 

package %w(httpd tomcat7 tomcat7-webapps tomcat8 tomcat8-webapps java-1.8.0-openjdk-devel.x86_64 ) do
  action :install
end

#set the port numbers here
template '/usr/share/tomcat8/' do
  source 'server.xml.erb'
end

#set the java home here
template '/usr/share/tomcat8/tomcat8.conf' do
  source 'tomcat8.conf.erb'
end


service 'tomcat7' do
  action [:enable, :restart]
end

service 'tomcat8' do
  action [:enable, :restart]
end