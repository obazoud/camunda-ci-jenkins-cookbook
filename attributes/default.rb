default['camunda']['jenkins']['installation']['timeout'] = 240
default['camunda']['jenkins']['version'] = '1.573'
default['camunda']['jenkins']['home'] = '/var/lib/jenkins'
default['camunda']['jenkins']['user'] = 'jenkins'

default['camunda']['jenkins']['admin_email'] = 'Jenkins &lt;maintenance@camunda.com&gt;'
default['camunda']['jenkins']['url'] = 'https://app.camunda.com/jenkins'
default['camunda']['jenkins']['security']['enabled'] = true
default['camunda']['jenkins']['security']['mode'] = 'password' # ldap or password supported
default['camunda']['jenkins']['users'] = []

default['camunda']['jenkins']['config'] = {
  version: node['camunda']['jenkins']['version'],
  executors: 2,
  systemmessage: '&lt;h2&gt;camunda CI server - &lt;a href=&quot;http://www.camunda.org&quot;&gt;www.camunda.org&lt;/a&gt;&lt;/h2&gt; created at ',
  useSecurity: node['camunda']['jenkins']['security']['enabled'],
  ldap: {},
  jdks: [
    { name: 'jdk-6-latest', version: 'jdk-6u45-oth-JPR' },
    { name: 'jdk-7-latest', version: 'jdk-7u65-oth-JPR' },
    { name: 'jdk-8-latest', version: 'jdk-8u11-oth-JPR' }
  ],
  installed_jdks: [
    # { name: 'oracle-jrockit-jdk1.6.0_45-R28.2.7-4.1.0', location: '/opt/java/Oracle-JDK/jrockit-jdk1.6.0_45-R28.2.7-4.1.0' }
  ]
}
default['camunda']['jenkins']['config']['tools']['jdk_installer']['username'] = 'christian.lipphardt@camunda.com'
default['camunda']['jenkins']['config']['tools']['jdk_installer']['password'] = '5lCN3gkvCMNpUm3gUG7GX+npaAfLWJeO3vqKDoinFKI='

# specify plugins to install eg. [ { name: 'docker-plugin', version: '' }, { name: '', version: '' } ]  - empty string for version means latest
default['camunda']['jenkins']['plugins'] = [
  # default plugins shipped with jenkins
  { name: 'credentials', version: '' },
  { name: 'ldap', version: '' },
  { name: 'mailer', version: '' },
  { name: 'matrix-auth', version: '' },
  { name: 'matrix-project', version: '' },
  { name: 'ssh-credentials', version: '' },
  { name: 'ssh-slaves', version: '' },

  # custom plugins
  { name: 'timestamper', version: '' },
  { name: 'groovy', version: '' },
  { name: 'email-ext', version: '' },
  { name: 'git', version: '' },
  { name: 'github', version: '' },
  { name: 'docker-plugin', version: '' },
  { name: 'job-dsl', version: '' },
  { name: 'rebuild', version: '' },
  { name: 'matrix-reloaded', version: '' },
  { name: 'build-timeout', version: '' },
  { name: 'build-failure-analyzer', version: '' }
]
default['camunda']['jenkins']['config']['tools']['ant'] = [
  { name: 'ant-1.8-latest', version: '1.8.4' },
  { name: 'ant-1.9-latest', version: '1.9.4' }
]
default['camunda']['jenkins']['config']['tools']['maven'] = [
  { name: 'maven-3.1-latest', version: '3.1.1' },
  { name: 'maven-3.2-latest', version: '3.2.2' }
]
default['camunda']['jenkins']['config']['tools']['groovy'] = [
  { name: 'groovy-2.2-latest', version: '2.2.1' }
]

default['camunda']['jenkins']['docker']['config']['plugin'] = [
  {
    name: 'localhost',
    serverUrl: 'http://127.0.0.1:2375',
    containerCap: 2,
    connectTimeout: 5,
    readTimeout: 15
  }
]
default['camunda']['jenkins']['docker']['config']['images'] = [
  {
    image: 'camunda/camunda-ci-docker-mysql',
    label: 'docker-mysql',
    credentialsId: '',
    dockerCommand: '',
    idleTerminationMinutes: 5,
    jvmOptions: '',
    javaPath: '',
    prefixStartSlaveCmd: '',
    suffixStartSlaveCmd: '',
    remoteFs: '/home/jenkins',
    hostname: '',
    instanceCap: 2,
    dnsHosts: ['8.8.8.8'],
    volumes: [],
    privileged: false
  }
]
