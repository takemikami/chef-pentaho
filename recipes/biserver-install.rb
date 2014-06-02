url = node['pentaho']['biserver']['url']
download_path = "#{Chef::Config[:file_cache_path]}/#{node['pentaho']['biserver']['binaryname']}"

if url != nil
  # download
  Chef::Log.debug "download pentaho biserver from sourceforge"
  bash "download" do
    code <<-EOH
      curl -L #{url} -o #{download_path}
    EOH
    not_if "test -f #{download_path}"
  end

  # tar install
  bash "install pentaho biserver" do
    code <<-EOH
      mkdir /usr/local/pentaho
      tar zxf #{download_path} -C /usr/local/pentaho
    EOH
    only_if "test ! -d /usr/local/pentaho/biserver-ce"
  end
  file "/usr/local/pentaho/biserver-ce/promptuser.sh" do
    action :delete
  end

  # replace fop.jar
  bash "replace fop.jar" do
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
      curl -L http://mirrors.ibiblio.org/maven2/fop/fop/0.20.5/fop-0.20.5.jar -o /usr/local/pentaho/biserver-ce/tomcat/webapps/pentaho/WEB-INF/lib/fop-0.20.5.jar
      rm /usr/local/pentaho/biserver-ce/tomcat/webapps/pentaho/WEB-INF/lib/fop-0.94.jar
    EOH
    not_if "test -f /usr/local/pentaho/biserver-ce/tomcat/webapps/pentaho/WEB-INF/lib/fop-0.20.5.jar"
  end

  template "/usr/local/pentaho/biserver-ce/pentaho-solutions/system/publisher_config.xml" do
    source "publisher_config.xml.erb"
    owner "root"
    group "root"
    mode "644"
  end

  # setup service
  template "/usr/local/sbin/pentahobictl" do
    source "pentahobictl.erb"
    owner "root"
    group "root"
    mode "744"
  end
  link "/etc/init.d/pentahobi" do
    to "/usr/local/sbin/pentahobictl"
  end
  bash "install pentahobi service" do
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
      chkconfig --add pentahobi
    EOH
    only_if "test `chkconfig --list | grep pentahobi | wc -l` -eq 0"
  end
  
  # start service
  service 'pentahobi' do
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
  end

else
  Chef::Log.error "Unsupported platform"

end