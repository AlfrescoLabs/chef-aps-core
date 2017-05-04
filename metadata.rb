name 'aps-core'
maintainer 'Alfresco T&A Team'
maintainer_email 'devops@alfresco.com'
license 'Apache 2.0'
description 'Installs/Configures aps-core'
long_description 'Installs/Configures aps-core'
version '0.1.0'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
issues_url 'https://github.com/Alfresco/aps-core/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
source_url 'https://github.com/Alfresco/aps-core' if respond_to?(:source_url)

chef_version '~> 12'
supports 'centos', '>= 7.0'
