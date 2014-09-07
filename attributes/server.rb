case node['platform_family']
when 'rhel', 'debian'
  default['pentaho']['biserver']['binaryname'] = "biserver-ce-5.0.1-stable.zip"
  default['pentaho']['biserver']['url'] = "http://downloads.sourceforge.net/project/pentaho/Business%20Intelligence%20Server/5.0.1-stable/biserver-ce-5.0.1-stable.zip?use_mirror=softlayer-dal"

else
  default['pentaho']['biserver']['url'] = nil

end
