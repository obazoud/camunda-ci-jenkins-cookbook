name             'camunda-ci-jenkins'
maintainer       'Christian Lipphardt'
maintainer_email 'christian.lipphardt@camunda.com'
license          'Apache 2.0'
description      'Installs/Configures camunda-ci-jenkins-cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'camunda-ci-jenkins::default', 'Installs/Configures the camunda-ci-jenkins.'

supports 'ubuntu', '14.04'

depends 'chef-sugar'
depends 'user'
depends 'jenkins'