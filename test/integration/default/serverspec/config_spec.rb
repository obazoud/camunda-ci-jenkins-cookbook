require 'spec_helper'

# chef
describe file('/var/lib/jenkins/config.xml') do
  its(:content) { should contain '' }
end

describe file('/etc/httpd/conf/httpd.conf') do
  it { should contain 'ServerName www.example.jp' }
end
