default['aps-core']['version'] = '1.6.0'
default['aps-core']['nexus']['username'] = 'your-nexus-username'
default['aps-core']['nexus']['password'] = 'your-nexus-password'

#db settings for activiti properties
default['aps-core']['db']['engine'] = 'mysql'
default['aps-core']['db']['host'] = 'locahost'

# mysql driver
default['aps-core']['mysql_driver']['version'] = '5.1.39'
mysql_driver_version = node['aps-core']['mysql_driver']['version']
default['aps-core']['mysql_driver']['url'] = lazy { "http://central.maven.org/maven2/mysql/mysql-connector-java/#{mysql_driver_version}/mysql-connector-java-#{mysql_driver_version}.jar" }
# postgres driver
default['aps-core']['postgres_driver']['version'] = '42.1.1'
postgres_driver_version = node['aps-core']['postgres_driver']['version']
default['aps-core']['postgres_driver']['url'] = lazy { "https://jdbc.postgresql.org/download/postgresql-#{postgres_driver_version}.jar" }
default['aps-core']['appserver']['tomcat_home'] = '/usr/share/tomcat'
