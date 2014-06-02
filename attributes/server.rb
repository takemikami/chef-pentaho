case node['platform_family']
when 'rhel'
  default['pentaho']['biserver']['binaryname'] = "biserver-ce-4.8.0-stable.tar.gz"
  default['pentaho']['biserver']['url'] = "http://downloads.sourceforge.net/project/pentaho/Business%20Intelligence%20Server/4.8.0-stable/biserver-ce-4.8.0-stable.tar.gz"

else
  default['pentaho']['biserver']['url'] = nil

end
