# Cookie secret
default['aps-core']['activiti-admin-properties']['security.rememberme.key'] = 'activitis3cr3tk3y'

# Database config
default['aps-core']['activiti-admin-properties']['datasource.driver'] = 'com.mysql.jdbc.Driver' if node['aps-core']['admin_db']['engine'] == 'mysql'
default['aps-core']['activiti-admin-properties']['datasource.driver'] = 'org.postgresql.Driver' if node['aps-core']['admin_db']['engine'] == 'postgres'
default['aps-core']['activiti-admin-properties']['datasource.driver'] = 'org.h2.Driver' if node['aps-core']['admin_db']['engine'] == 'h2'

# Database username and password
default['aps-core']['activiti-admin-properties']['datasource.username'] = 'alfresco'
default['aps-core']['activiti-admin-properties']['datasource.password'] = 'alfresco'

# Datasource URL
default['aps-core']['activiti-admin-properties']['datasource.url'] = lazy { "jdbc:mysql://#{node['aps-core']['admin_db']['host']}:3306/activitiadmin?connectTimeout=240000&socketTimeout=240000&autoReconnect=true&characterEncoding=UTF-8" } if node['aps-core']['admin_db']['engine'] == 'mysql'
default['aps-core']['activiti-admin-properties']['datasource.url'] = lazy { "jdbc:postgresql://#{node['aps-core']['admin_db']['host']}:5432/activitiadmin?characterEncoding=UTF-8" } if node['aps-core']['admin_db']['engine'] == 'postgres'
default['aps-core']['activiti-admin-properties']['datasource.url'] = 'jdbc:h2:mem:db1;DB_CLOSE_DELAY=1000' if node['aps-core']['admin_db']['engine'] == 'h2'

# Datasource dialect
default['aps-core']['activiti-admin-properties']['hibernate.dialect'] = 'org.hibernate.dialect.MySQLDialect' if node['aps-core']['admin_db']['engine'] == 'mysql'
default['aps-core']['activiti-admin-properties']['hibernate.dialect'] = 'org.hibernate.dialect.PostgreSQLDialect' if node['aps-core']['admin_db']['engine'] == 'postgres'
default['aps-core']['activiti-admin-properties']['hibernate.dialect'] = 'org.hibernate.dialect.H2Dialect' if node['aps-core']['admin_db']['engine'] == 'h2'

# Other defaults
default['aps-core']['activiti-admin-properties']['cluster.monitoring.max.inactive.time'] = 600000
default['aps-core']['activiti-admin-properties']['cluster.monitoring.inactive.check.cronexpression'] = '0 0/5 * * * ?'
default['aps-core']['activiti-admin-properties']['rest.app.name'] = 'Activiti app'
default['aps-core']['activiti-admin-properties']['rest.app.description'] = 'Activiti app Rest config'
default['aps-core']['activiti-admin-properties']['rest.app.host'] = 'http://localhost' # only if deployed on the same host as Activiti
default['aps-core']['activiti-admin-properties']['rest.app.port'] = 8080
default['aps-core']['activiti-admin-properties']['rest.app.contextroot'] = lazy { node['aps-core']['activiti-app-properties']['server.contextroot'] }
default['aps-core']['activiti-admin-properties']['rest.app.restroot'] = 'api'

# These are the credentials for the activiti-app webapp, not the admin app. Creds for admin are admin/admin....
default['aps-core']['activiti-admin-properties']['rest.app.user'] = lazy { node['aps-core']['activiti-app-properties']['admin.email'] }
default['aps-core']['activiti-admin-properties']['rest.app.password'] = 'admin'

default['aps-core']['activiti-admin-properties']['security.encryption.credentialsIVSpec'] = 'j8kdO2hejA9lKmm6'
default['aps-core']['activiti-admin-properties']['security.encryption/credentialsSecretSpec'] = '9FGl73ngxcOoJvmL'
default['aps-core']['activiti-admin-properties']['modeler.url'] = 'https://activiti.alfresco.com/activiti-app/api/'

## An example is shown below of a typical activiti-admin.properties file
# ======================================================================
# H2 example (default)
# datasource.driver=org.h2.Driver
# datasource.url=jdbc:h2:tcp://localhost/activitiadmin

# MySQL example
# datasource.driver=com.mysql.jdbc.Driver
# datasource.url=jdbc:mysql://127.0.0.1:3306/activitiadmin?characterEncoding=UTF-8

# datasource.driver=org.postgresql.Driver
# datasource.url=jdbc:postgresql://localhost:5432/activitiadmin

# datasource.driver=com.microsoft.sqlserver.jdbc.SQLServerDriver
# datasource.url=jdbc:sqlserver://localhost:1433;databaseName=activitiadmin

# datasource.driver=oracle.jdbc.driver.OracleDriver
# datasource.url=jdbc:oracle:thin:@localhost:1521:ACTIVITIADMIN

# datasource.driver=com.ibm.db2.jcc.DB2Driver
# datasource.url=jdbc:db2://localhost:50000/activitiadmin

# datasource.username=activiti
# datasource.password=

# JNDI CONFIG
# If uncommented, the datasource will be looked up using the configured JNDI name.
# This will have preference over any datasource configuration done below that doesn't use JNDI
#
# Eg for JBoss: java:jboss/datasources/activitiDS
#
# datasource.jndi.name=jdbc/activitiDS

# Set whether the lookup occurs in a J2EE container, i.e. if the prefix "java:comp/env/" needs to be added if the JNDI
# name doesn't already contain it. Default is "true".
# datasource.jndi.resourceRef=true

# hibernate.dialect=org.hibernate.dialect.H2Dialect
# hibernate.dialect=org.hibernate.dialect.MySQLDialect
# hibernate.dialect=org.hibernate.dialect.Oracle10gDialect
# hibernate.dialect=org.hibernate.dialect.SQLServerDialect
# hibernate.dialect=org.hibernate.dialect.DB2Dialect
# hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
# hibernate.show_sql=false
# hibernate.generate_statistics=false

#
# Connection pool (see http://www.mchange.com/projects/c3p0/#configuration)
#

# datasource.min-pool-size=5
# datasource.max-pool-size=100
# datasource.acquire-increment=5
# test query for H2, MySQL, PostgreSQL and Microsoft SQL Server
# datasource.preferred-test-query=select 1
# test query for Oracle
# datasource.preferred-test-query=SELECT 1 FROM DUAL
# test query for DB2
# datasource.preferred-test-query=SELECT current date FROM sysibm.sysdummy1
# datasource.test-connection-on-checkin=true
# datasource.test-connection-on-checkout=true
# datasource.max-idle-time=1800
# datasource.max-idle-time-excess-connections=1800

#
# Cluster settings
#

# This a period of time, expressed in milliseconds, that indicates
# when a node is deemed to be inactive and is removed from the list
# of nodes of a cluster (nor will it appear in the 'monitoring' section of the application).
#
# When a node is properly shut down, it will send out an event indicating
# it is shut down. From that point on, the data will be kept in memory for the amount
# of time indicated here.
# When a node is not properly shut down (eg hardware failure), this is the period of time
# before removal, since the time the last event is received.
#
# Make sure the value here is higher than the sending interval of the nodes, to avoid
# that nodes incorrectly removed.
#
# By default 10 minutes
# cluster.monitoring.max.inactive.time=600000

# A cron expression that configures when the check for inactive nodes is made.
# When executed, this will mark any node that hasn't been active for 'cluster.monitoring.max.inactive.time'
# seconds, as an inactive node. Default: every 5 minutes.
# cluster.monitoring.inactive.check.cronexpression=0 0/5 * * * ?

# REST endpoint config
# rest.app.name=Activiti app
# rest.app.description=Activiti app Rest config
# rest.app.host=http://localhost
# rest.app.port=8080
# rest.app.contextroot=activiti-app
# rest.app.restroot=api
# rest.app.user=admin@app.activiti.com
# rest.app.password=admin

# Passwords for rest endpoints and master configs are stored encrypted in the database using AES/CBC/PKCS5PADDING
# It needs a 128-bit initialization vector (http://en.wikipedia.org/wiki/Initialization_vector)
# and a 128-bit secret key represented as 16 ascii characters below
#
# Do note that if these properties are changed after passwords have been saved, all existing passwords
# will not be able to be decrypted and the password would need to be reset in the UI.
# security.encryption.credentialsIVSpec=j8kdO2hejA9lKmm6
# security.encryption.credentialsSecretSpec=9FGl73ngxcOoJvmL

# BPMN 2.0 Modeler config

# modeler.url=https://activiti.alfresco.com/activiti-app/api/
