package %w(httpd tomcat7 tomcat7-webapps) do
  action :install
end

service 'tomcat7' do
  action [:enable, :restart]
end

template '/etc/httpd/conf.d/proxy.conf' do
  source 'proxy.conf.erb'
end

service 'httpd' do
  action [:enable, :restart]
end