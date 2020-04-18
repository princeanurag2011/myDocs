package 'httpd'
package 'tomcat7'
package 'tomcat7-webapps'

file '/etc/httpd/conf.d/proxy.conf' do
	content "ProxyPass /examples"
	content "ProxyPassReverse /examples"
end

service 'httpd' do
	action: restart
end
service 'tomcat7' do
	action: restart
end