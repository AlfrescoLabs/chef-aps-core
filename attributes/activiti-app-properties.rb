default['aps-core']['activiti-app-properties']['server.onpremise'] = true
default['aps-core']['activiti-app-properties']['server.stencil.custom.allowed'] = true
default['aps-core']['activiti-app-properties']['server.contextroot'] = '/activiti-app'
default['aps-core']['activiti-app-properties']['license.multi-tenant'] = false

# Database username and password
default['aps-core']['activiti-app-properties']['datasource.username'] = 'alfresco'
default['aps-core']['activiti-app-properties']['datasource.password'] = 'alfresco'

# Driver to be used
default['aps-core']['activiti-app-properties']['datasource.driver'] = 'com.mysql.jdbc.Driver' if node['aps-core']['db']['engine'] == 'mysql'
default['aps-core']['activiti-app-properties']['datasource.driver'] = 'org.postgresql.Driver' if node['aps-core']['db']['engine'] == 'postgres'

# This should point to your database ( external possibly )
default['aps-core']['activiti-app-properties']['datasource.url'] = lazy { "jdbc:mysql://#{node['aps-core']['db']['host']}:3306/process?connectTimeout=240000&socketTimeout=240000&autoReconnect=true&characterEncoding=UTF-8" } if node['aps-core']['db']['engine'] == 'mysql'
default['aps-core']['activiti-app-properties']['datasource.url'] = lazy { "jdbc:postgresql://#{node['aps-core']['db']['host']}:5432/process?characterEncoding=UTF-8" } if node['aps-core']['db']['engine'] == 'postgres'

# Hibernate dialect of choice
default['aps-core']['activiti-app-properties']['hibernate.dialect'] = 'org.hibernate.dialect.MySQLDialect' if node['aps-core']['db']['engine'] == 'mysql'
default['aps-core']['activiti-app-properties']['hibernate.dialect'] = 'org.hibernate.dialect.PostgreSQLDialect' if node['aps-core']['db']['engine'] == 'postgres'

default['aps-core']['activiti-app-properties']['elastic-search.server.type'] = 'embedded'
# default['aps-core']['activiti-app-properties']['elastic-search.discovery.type'] = unicast
# default['aps-core']['activiti-app-properties']['elastic-search.cluster.name'] = elasticsearch
# default['aps-core']['activiti-app-properties']['elastic-search.discovery.hosts'] = localhost:9300
default['aps-core']['activiti-app-properties']['elastic-search.data.path'] = lazy { "#{node['appserver']['home']}/activiti-elastic-search-data" }
default['aps-core']['activiti-app-properties']['event.generation.enabled'] = true
default['aps-core']['activiti-app-properties']['event.processing.enabled'] = true

# Admin user informations
#  user: admin@app.activiti.com , password: admin.
default['aps-core']['activiti-app-properties']['admin.email'] = 'admin@app.activiti.com'
default['aps-core']['activiti-app-properties']['admin.passwordHash'] = '25a463679c56c474f20d8f592e899ef4cb3f79177c19e3782ed827b5c0135c466256f1e7b60e576e'
default['aps-core']['activiti-app-properties']['admin.lastname'] = 'Administrator'
default['aps-core']['activiti-app-properties']['admin.group'] = 'Administrators'

# ContentStorage
# http://docs.alfresco.com/activiti/docs/admin-guide/1.5.0/#contentStorageConfig for reference
default['aps-core']['activiti-app-properties']['contentstorage.fs.rootFolder'] = '/usr/local/data/'
default['aps-core']['activiti-app-properties']['contentstorage.fs.createRoot'] = true
default['aps-core']['activiti-app-properties']['contentstorage.fs.depth'] = 4
default['aps-core']['activiti-app-properties']['contentstorage.fs.blockSize'] = 1024

# Security settings
default['aps-core']['activiti-app-properties']['security.csrf.disabled'] = false

# password min length
default['aps-core']['activiti-app-properties']['security.password.constraints.min-length'] = 8
default['aps-core']['activiti-app-properties']['security.password.constraints.reg-exp'] = '^(?=.*[a-z])(?=.*[A-Z]).+$'
# USER TOKEN TTL
# after how long the cookie should expire
default['aps-core']['activiti-app-properties']['security.cookie.max-age'] = 1800
# how often the cookie get controlled
default['aps-core']['activiti-app-properties']['security.cookie.database-removal.cronExpression'] = '0 0/10 * * * ?'

# SIGN UP TO THE APP
default['aps-core']['activiti-app-properties']['security.signup.disabled'] = true

# DISABLE SCRIPTING
default['aps-core']['activiti-app-properties']['validator.editor.bpmn.disable.scripttask'] = true
default['aps-core']['activiti-app-properties']['validator.editor.bpmn.disable.scripttask.groovy'] = true

# Beans whitelisting
default['aps-core']['activiti-app-properties']['beans.whitelisting.enabled'] = true

# EL whitelisting
default['aps-core']['activiti-app-properties']['el.whitelisting.enabled'] = true

# CORS settings
default['aps-core']['activiti-app-properties']['cors.enabled'] = true
default['aps-core']['activiti-app-properties']['cors.allowed.origins'] = '*'
default['aps-core']['activiti-app-properties']['cors.allowed.methods'] = 'GET,POST,HEAD,OPTIONS,PUT,DELETE'
default['aps-core']['activiti-app-properties']['cors.allowed.headers'] = 'Authorization,Content-Type,Cache-Control,X-Requested-With,accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers,X-CSRF-Token'
default['aps-core']['activiti-app-properties']['cors.exposed.headers'] = 'Access-Control-Allow-Origin,Access-Control-Allow-Credentials'
default['aps-core']['activiti-app-properties']['cors.support.credentials'] = true
default['aps-core']['activiti-app-properties']['cors.preflight.maxage'] = 10
default['aps-core']['activiti-app-properties']['spring.freemarker.template-loader-path'] = 'classpath:/email-templates'
